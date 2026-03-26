ALTER TABLE llx_scolaris_level ADD UNIQUE INDEX uk_scolaris_level_code (entity, code);
ALTER TABLE llx_scolaris_level ADD INDEX idx_scolaris_level_status (entity, status);
