ALTER TABLE llx_scolaris_course_assignment ADD UNIQUE INDEX uk_scolaris_course_assignment (entity, fk_course, fk_user, role_code);
ALTER TABLE llx_scolaris_course_assignment ADD INDEX idx_scolaris_course_assignment_user (fk_user);
ALTER TABLE llx_scolaris_course_assignment ADD INDEX idx_scolaris_course_assignment_year (fk_academic_year);
