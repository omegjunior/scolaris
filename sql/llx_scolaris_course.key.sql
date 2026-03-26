ALTER TABLE llx_scolaris_course ADD UNIQUE INDEX uk_scolaris_course_code (entity, fk_academic_year, code);
ALTER TABLE llx_scolaris_course ADD INDEX idx_scolaris_course_semester (fk_semester);
ALTER TABLE llx_scolaris_course ADD INDEX idx_scolaris_course_typology (fk_typology);
ALTER TABLE llx_scolaris_course ADD INDEX idx_scolaris_course_year (fk_academic_year);
ALTER TABLE llx_scolaris_course ADD INDEX idx_scolaris_course_status (entity, status);
