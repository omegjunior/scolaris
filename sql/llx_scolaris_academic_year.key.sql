ALTER TABLE llx_scolaris_academic_year ADD UNIQUE INDEX uk_scolaris_academic_year_code (entity, code);
ALTER TABLE llx_scolaris_academic_year ADD INDEX idx_scolaris_academic_year_status (entity, status);
ALTER TABLE llx_scolaris_academic_year ADD INDEX idx_scolaris_academic_year_current (entity, is_current);
