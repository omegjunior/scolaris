ALTER TABLE llx_scolaris_typology_result ADD UNIQUE INDEX uk_scolaris_typology_result (entity, fk_enrollment, fk_semester, fk_typology);
ALTER TABLE llx_scolaris_typology_result ADD INDEX idx_scolaris_typology_result_student (fk_student);
ALTER TABLE llx_scolaris_typology_result ADD INDEX idx_scolaris_typology_result_semester (fk_semester);
ALTER TABLE llx_scolaris_typology_result ADD INDEX idx_scolaris_typology_result_typology (fk_typology);
