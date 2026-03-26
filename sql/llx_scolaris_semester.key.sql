ALTER TABLE llx_scolaris_semester ADD UNIQUE INDEX uk_scolaris_semester_code (entity, code);
ALTER TABLE llx_scolaris_semester ADD INDEX idx_scolaris_semester_level (fk_level);
ALTER TABLE llx_scolaris_semester ADD INDEX idx_scolaris_semester_status (entity, status);
