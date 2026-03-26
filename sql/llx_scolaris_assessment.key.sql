ALTER TABLE llx_scolaris_assessment ADD UNIQUE INDEX uk_scolaris_assessment_code (entity, fk_course, code);
ALTER TABLE llx_scolaris_assessment ADD INDEX idx_scolaris_assessment_course (fk_course);
ALTER TABLE llx_scolaris_assessment ADD INDEX idx_scolaris_assessment_year (fk_academic_year);
ALTER TABLE llx_scolaris_assessment ADD INDEX idx_scolaris_assessment_status (entity, status);
ALTER TABLE llx_scolaris_assessment ADD INDEX idx_scolaris_assessment_type (assessment_type, session_type);
