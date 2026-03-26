ALTER TABLE llx_scolaris_rule_line ADD UNIQUE INDEX uk_scolaris_rule_line (entity, fk_rule_profile, target_type, target_code);
ALTER TABLE llx_scolaris_rule_line ADD INDEX idx_scolaris_rule_line_profile (fk_rule_profile);
