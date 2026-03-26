ALTER TABLE llx_scolaris_user_scope ADD UNIQUE INDEX uk_scolaris_user_scope (entity, fk_user, fk_academic_year, fk_semester, fk_course);
ALTER TABLE llx_scolaris_user_scope ADD INDEX idx_scolaris_user_scope_user (fk_user);
ALTER TABLE llx_scolaris_user_scope ADD INDEX idx_scolaris_user_scope_filters (fk_academic_year, fk_semester, fk_course);
