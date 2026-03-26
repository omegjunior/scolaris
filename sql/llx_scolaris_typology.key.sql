ALTER TABLE llx_scolaris_typology ADD UNIQUE INDEX uk_scolaris_typology_code (entity, code);
ALTER TABLE llx_scolaris_typology ADD INDEX idx_scolaris_typology_status (entity, status);
