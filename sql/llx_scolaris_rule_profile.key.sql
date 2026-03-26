ALTER TABLE llx_scolaris_rule_profile ADD UNIQUE INDEX uk_scolaris_rule_profile_code (entity, code);
ALTER TABLE llx_scolaris_rule_profile ADD INDEX idx_scolaris_rule_profile_status (entity, status);
ALTER TABLE llx_scolaris_rule_profile ADD INDEX idx_scolaris_rule_profile_default (entity, is_default);
