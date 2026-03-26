ALTER TABLE llx_scolaris_audit ADD INDEX idx_scolaris_audit_object (object_type, fk_object);
ALTER TABLE llx_scolaris_audit ADD INDEX idx_scolaris_audit_action (action_code);
ALTER TABLE llx_scolaris_audit ADD INDEX idx_scolaris_audit_date (date_action);
