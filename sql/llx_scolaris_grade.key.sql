ALTER TABLE llx_scolaris_grade ADD UNIQUE INDEX uk_scolaris_grade (entity, fk_assessment, fk_enrollment);
ALTER TABLE llx_scolaris_grade ADD INDEX idx_scolaris_grade_assessment (fk_assessment);
ALTER TABLE llx_scolaris_grade ADD INDEX idx_scolaris_grade_student (fk_student);
ALTER TABLE llx_scolaris_grade ADD INDEX idx_scolaris_grade_enrollment (fk_enrollment);
ALTER TABLE llx_scolaris_grade ADD INDEX idx_scolaris_grade_status (entity, status);
ALTER TABLE llx_scolaris_grade ADD INDEX idx_scolaris_grade_publish (entity, is_published);
