from __future__ import annotations

import argparse
import datetime as dt
import os
import re
import zipfile
from pathlib import Path
from xml.sax.saxutils import escape


XML_DECL = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'


def normalize_inline(text: str) -> str:
    text = text.replace("\t", "    ").strip()
    text = re.sub(r"`([^`]*)`", r"\1", text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"\1", text)
    text = re.sub(r"\*([^*]+)\*", r"\1", text)
    text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", text)
    return text


def is_table_separator(line: str) -> bool:
    stripped = line.strip()
    if not (stripped.startswith("|") and stripped.endswith("|")):
        return False
    cells = [c.strip() for c in stripped.strip("|").split("|")]
    if not cells:
        return False
    return all(c and set(c) <= set("-: ") for c in cells)


def parse_table_row(line: str) -> list[str]:
    return [normalize_inline(c.strip()) for c in line.strip().strip("|").split("|")]


def split_blocks(text: str) -> list[dict]:
    lines = text.splitlines()
    blocks: list[dict] = []
    i = 0
    while i < len(lines):
        line = lines[i].rstrip()
        stripped = line.strip()

        if not stripped:
            i += 1
            continue

        if stripped.startswith("|") and stripped.endswith("|"):
            table_lines = [stripped]
            i += 1
            while i < len(lines):
                candidate = lines[i].strip()
                if candidate.startswith("|") and candidate.endswith("|"):
                    table_lines.append(candidate)
                    i += 1
                    continue
                break

            rows = []
            for idx, table_line in enumerate(table_lines):
                if idx == 1 and is_table_separator(table_line):
                    continue
                if is_table_separator(table_line):
                    continue
                rows.append(parse_table_row(table_line))
            if rows:
                blocks.append({"type": "table", "rows": rows})
            continue

        if stripped.startswith("#"):
            level = len(stripped) - len(stripped.lstrip("#"))
            text_value = normalize_inline(stripped[level:].strip())
            blocks.append({"type": "heading", "level": min(level, 4), "text": text_value})
            i += 1
            continue

        if re.match(r"^[-*]\s+", stripped):
            items = []
            while i < len(lines):
                candidate = lines[i].strip()
                if re.match(r"^[-*]\s+", candidate):
                    items.append(normalize_inline(re.sub(r"^[-*]\s+", "", candidate)))
                    i += 1
                    continue
                if not candidate:
                    i += 1
                    continue
                break
            blocks.append({"type": "bullets", "items": items})
            continue

        if re.match(r"^\d+\.\s+", stripped):
            items = []
            while i < len(lines):
                candidate = lines[i].strip()
                if re.match(r"^\d+\.\s+", candidate):
                    items.append(normalize_inline(re.sub(r"^\d+\.\s+", "", candidate)))
                    i += 1
                    continue
                if not candidate:
                    i += 1
                    continue
                break
            blocks.append({"type": "numbered", "items": items})
            continue

        paragraph_lines = [normalize_inline(stripped)]
        i += 1
        while i < len(lines):
            candidate = lines[i].strip()
            if not candidate:
                i += 1
                break
            if candidate.startswith("#") or candidate.startswith("|") or re.match(r"^[-*]\s+", candidate) or re.match(r"^\d+\.\s+", candidate):
                break
            paragraph_lines.append(normalize_inline(candidate))
            i += 1
        blocks.append({"type": "paragraph", "text": " ".join(paragraph_lines)})

    return blocks


def paragraph_xml(text: str, style: str | None = None) -> str:
    escaped = escape(text)
    ppr = f"<w:pPr><w:pStyle w:val=\"{style}\"/></w:pPr>" if style else ""
    return f"<w:p>{ppr}<w:r><w:t xml:space=\"preserve\">{escaped}</w:t></w:r></w:p>"


def make_table(rows: list[list[str]]) -> str:
    max_cols = max(len(row) for row in rows)
    norm_rows = [row + [""] * (max_cols - len(row)) for row in rows]

    tbl = [
        "<w:tbl>",
        "<w:tblPr>",
        "<w:tblStyle w:val=\"TableGrid\"/>",
        "<w:tblW w:w=\"0\" w:type=\"auto\"/>",
        "</w:tblPr>",
        "<w:tblGrid>",
    ]
    for _ in range(max_cols):
        tbl.append("<w:gridCol w:w=\"1800\"/>")
    tbl.append("</w:tblGrid>")

    for ridx, row in enumerate(norm_rows):
        tbl.append("<w:tr>")
        for cell in row:
            style = "TableHeader" if ridx == 0 else None
            cell_para = paragraph_xml(cell, style)
            tbl.append("<w:tc><w:tcPr><w:tcW w:w=\"0\" w:type=\"auto\"/></w:tcPr>")
            tbl.append(cell_para)
            tbl.append("</w:tc>")
        tbl.append("</w:tr>")
    tbl.append("</w:tbl>")
    return "".join(tbl)


def document_xml(blocks: list[dict]) -> str:
    body = []
    for block in blocks:
        if block["type"] == "heading":
            style = {
                1: "Heading1",
                2: "Heading2",
                3: "Heading3",
                4: "Heading4",
            }[block["level"]]
            body.append(paragraph_xml(block["text"], style))
        elif block["type"] == "paragraph":
            body.append(paragraph_xml(block["text"]))
        elif block["type"] == "bullets":
            for item in block["items"]:
                body.append(paragraph_xml(f"• {item}", "ListParagraph"))
        elif block["type"] == "numbered":
            for idx, item in enumerate(block["items"], start=1):
                body.append(paragraph_xml(f"{idx}. {item}", "ListParagraph"))
        elif block["type"] == "table":
            body.append(make_table(block["rows"]))
            body.append(paragraph_xml(""))

    body.append(
        "<w:sectPr>"
        "<w:pgSz w:w=\"11906\" w:h=\"16838\"/>"
        "<w:pgMar w:top=\"1134\" w:right=\"1134\" w:bottom=\"1134\" w:left=\"1134\" "
        "w:header=\"708\" w:footer=\"708\" w:gutter=\"0\"/>"
        "</w:sectPr>"
    )

    return (
        XML_DECL
        + "<w:document xmlns:wpc=\"http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas\" "
        "xmlns:mc=\"http://schemas.openxmlformats.org/markup-compatibility/2006\" "
        "xmlns:o=\"urn:schemas-microsoft-com:office:office\" "
        "xmlns:r=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships\" "
        "xmlns:m=\"http://schemas.openxmlformats.org/officeDocument/2006/math\" "
        "xmlns:v=\"urn:schemas-microsoft-com:vml\" "
        "xmlns:wp14=\"http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing\" "
        "xmlns:wp=\"http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing\" "
        "xmlns:w10=\"urn:schemas-microsoft-com:office:word\" "
        "xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" "
        "xmlns:w14=\"http://schemas.microsoft.com/office/word/2010/wordml\" "
        "xmlns:wpg=\"http://schemas.microsoft.com/office/word/2010/wordprocessingGroup\" "
        "xmlns:wpi=\"http://schemas.microsoft.com/office/word/2010/wordprocessingInk\" "
        "xmlns:wne=\"http://schemas.microsoft.com/office/word/2006/wordml\" "
        "xmlns:wps=\"http://schemas.microsoft.com/office/word/2010/wordprocessingShape\" "
        "mc:Ignorable=\"w14 wp14\">"
        + "<w:body>"
        + "".join(body)
        + "</w:body></w:document>"
    )


def styles_xml() -> str:
    return (
        XML_DECL
        + "<w:styles xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\">"
        + "<w:style w:type=\"paragraph\" w:default=\"1\" w:styleId=\"Normal\">"
        + "<w:name w:val=\"Normal\"/>"
        + "<w:qFormat/>"
        + "<w:rPr><w:sz w:val=\"22\"/></w:rPr>"
        + "</w:style>"
        + "<w:style w:type=\"paragraph\" w:styleId=\"Heading1\"><w:name w:val=\"heading 1\"/>"
        + "<w:basedOn w:val=\"Normal\"/><w:qFormat/>"
        + "<w:rPr><w:b/><w:sz w:val=\"30\"/></w:rPr></w:style>"
        + "<w:style w:type=\"paragraph\" w:styleId=\"Heading2\"><w:name w:val=\"heading 2\"/>"
        + "<w:basedOn w:val=\"Normal\"/><w:qFormat/>"
        + "<w:rPr><w:b/><w:sz w:val=\"26\"/></w:rPr></w:style>"
        + "<w:style w:type=\"paragraph\" w:styleId=\"Heading3\"><w:name w:val=\"heading 3\"/>"
        + "<w:basedOn w:val=\"Normal\"/><w:qFormat/>"
        + "<w:rPr><w:b/><w:sz w:val=\"24\"/></w:rPr></w:style>"
        + "<w:style w:type=\"paragraph\" w:styleId=\"Heading4\"><w:name w:val=\"heading 4\"/>"
        + "<w:basedOn w:val=\"Normal\"/><w:qFormat/>"
        + "<w:rPr><w:b/><w:sz w:val=\"22\"/></w:rPr></w:style>"
        + "<w:style w:type=\"paragraph\" w:styleId=\"ListParagraph\"><w:name w:val=\"List Paragraph\"/>"
        + "<w:basedOn w:val=\"Normal\"/><w:pPr><w:ind w:left=\"360\"/></w:pPr></w:style>"
        + "<w:style w:type=\"paragraph\" w:styleId=\"TableHeader\"><w:name w:val=\"Table Header\"/>"
        + "<w:basedOn w:val=\"Normal\"/><w:rPr><w:b/></w:rPr></w:style>"
        + "<w:style w:type=\"table\" w:default=\"1\" w:styleId=\"TableGrid\"><w:name w:val=\"Table Grid\"/>"
        + "<w:tblPr><w:tblBorders>"
        + "<w:top w:val=\"single\" w:sz=\"4\" w:space=\"0\" w:color=\"auto\"/>"
        + "<w:left w:val=\"single\" w:sz=\"4\" w:space=\"0\" w:color=\"auto\"/>"
        + "<w:bottom w:val=\"single\" w:sz=\"4\" w:space=\"0\" w:color=\"auto\"/>"
        + "<w:right w:val=\"single\" w:sz=\"4\" w:space=\"0\" w:color=\"auto\"/>"
        + "<w:insideH w:val=\"single\" w:sz=\"4\" w:space=\"0\" w:color=\"auto\"/>"
        + "<w:insideV w:val=\"single\" w:sz=\"4\" w:space=\"0\" w:color=\"auto\"/>"
        + "</w:tblBorders></w:tblPr></w:style>"
        + "</w:styles>"
    )


def content_types_xml() -> str:
    return (
        XML_DECL
        + "<Types xmlns=\"http://schemas.openxmlformats.org/package/2006/content-types\">"
        + "<Default Extension=\"rels\" ContentType=\"application/vnd.openxmlformats-package.relationships+xml\"/>"
        + "<Default Extension=\"xml\" ContentType=\"application/xml\"/>"
        + "<Override PartName=\"/word/document.xml\" ContentType=\"application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml\"/>"
        + "<Override PartName=\"/word/styles.xml\" ContentType=\"application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml\"/>"
        + "<Override PartName=\"/docProps/core.xml\" ContentType=\"application/vnd.openxmlformats-package.core-properties+xml\"/>"
        + "<Override PartName=\"/docProps/app.xml\" ContentType=\"application/vnd.openxmlformats-officedocument.extended-properties+xml\"/>"
        + "</Types>"
    )


def root_rels_xml() -> str:
    return (
        XML_DECL
        + "<Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\">"
        + "<Relationship Id=\"rId1\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument\" Target=\"word/document.xml\"/>"
        + "<Relationship Id=\"rId2\" Type=\"http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties\" Target=\"docProps/core.xml\"/>"
        + "<Relationship Id=\"rId3\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties\" Target=\"docProps/app.xml\"/>"
        + "</Relationships>"
    )


def document_rels_xml() -> str:
    return (
        XML_DECL
        + "<Relationships xmlns=\"http://schemas.openxmlformats.org/package/2006/relationships\">"
        + "<Relationship Id=\"rId1\" Type=\"http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles\" Target=\"styles.xml\"/>"
        + "</Relationships>"
    )


def core_xml(title: str) -> str:
    created = dt.datetime.utcnow().replace(microsecond=0).isoformat() + "Z"
    return (
        XML_DECL
        + "<cp:coreProperties xmlns:cp=\"http://schemas.openxmlformats.org/package/2006/metadata/core-properties\" "
        + "xmlns:dc=\"http://purl.org/dc/elements/1.1/\" "
        + "xmlns:dcterms=\"http://purl.org/dc/terms/\" "
        + "xmlns:dcmitype=\"http://purl.org/dc/dcmitype/\" "
        + "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"
        + f"<dc:title>{escape(title)}</dc:title>"
        + "<dc:creator>Codex</dc:creator>"
        + "<cp:lastModifiedBy>Codex</cp:lastModifiedBy>"
        + f"<dcterms:created xsi:type=\"dcterms:W3CDTF\">{created}</dcterms:created>"
        + f"<dcterms:modified xsi:type=\"dcterms:W3CDTF\">{created}</dcterms:modified>"
        + "</cp:coreProperties>"
    )


def app_xml() -> str:
    return (
        XML_DECL
        + "<Properties xmlns=\"http://schemas.openxmlformats.org/officeDocument/2006/extended-properties\" "
        + "xmlns:vt=\"http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes\">"
        + "<Application>Microsoft Office Word</Application>"
        + "</Properties>"
    )


def export_markdown_to_docx(source: Path, target: Path) -> None:
    text = source.read_text(encoding="utf-8")
    blocks = split_blocks(text)
    title = source.stem.replace("_", " ")

    target.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(target, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("[Content_Types].xml", content_types_xml())
        zf.writestr("_rels/.rels", root_rels_xml())
        zf.writestr("docProps/core.xml", core_xml(title))
        zf.writestr("docProps/app.xml", app_xml())
        zf.writestr("word/document.xml", document_xml(blocks))
        zf.writestr("word/styles.xml", styles_xml())
        zf.writestr("word/_rels/document.xml.rels", document_rels_xml())


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("sources", nargs="+", help="Markdown source files")
    parser.add_argument("--output-dir", default="build/docx", help="Output directory for generated docx files")
    args = parser.parse_args()

    output_dir = Path(args.output_dir)
    for source_name in args.sources:
        source = Path(source_name)
        if not source.exists():
            raise FileNotFoundError(source)
        target = output_dir / f"{source.stem}.docx"
        export_markdown_to_docx(source, target)
        print(os.fspath(target))


if __name__ == "__main__":
    main()
