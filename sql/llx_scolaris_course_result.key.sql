ALTER TABLE llx_scolaris_course_result ADD UNIQUE INDEX uk_scolaris_course_result (entity, fk_enrollment, fk_course, session_type);
ALTER TABLE llx_scolaris_course_result ADD INDEX idx_scolaris_course_result_student (fk_student);
ALTER TABLE llx_scolaris_course_result ADD INDEX idx_scolaris_course_result_semester (fk_semester);
ALTER TABLE llx_scolaris_course_result ADD INDEX idx_scolaris_course_result_course (fk_course);
ALTER TABLE llx_scolaris_course_result ADD INDEX idx_scolaris_course_result_status (entity, status);
