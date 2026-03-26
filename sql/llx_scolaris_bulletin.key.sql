ALTER TABLE llx_scolaris_bulletin ADD UNIQUE INDEX uk_scolaris_bulletin_ref (entity, doc_ref);
ALTER TABLE llx_scolaris_bulletin ADD UNIQUE INDEX uk_scolaris_bulletin_version (entity, fk_semester_result, version_number);
ALTER TABLE llx_scolaris_bulletin ADD INDEX idx_scolaris_bulletin_student (fk_student);
ALTER TABLE llx_scolaris_bulletin ADD INDEX idx_scolaris_bulletin_semester (fk_semester);
ALTER TABLE llx_scolaris_bulletin ADD INDEX idx_scolaris_bulletin_publish (entity, publication_status);
ALTER TABLE llx_scolaris_bulletin ADD INDEX idx_scolaris_bulletin_payment (entity, payment_status);
