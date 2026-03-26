ALTER TABLE llx_scolaris_semester_result ADD UNIQUE INDEX uk_scolaris_semester_result (entity, fk_enrollment, fk_semester, attempt_number);
ALTER TABLE llx_scolaris_semester_result ADD INDEX idx_scolaris_semester_result_student (fk_student);
ALTER TABLE llx_scolaris_semester_result ADD INDEX idx_scolaris_semester_result_semester (fk_semester);
ALTER TABLE llx_scolaris_semester_result ADD INDEX idx_scolaris_semester_result_status (entity, status);
ALTER TABLE llx_scolaris_semester_result ADD INDEX idx_scolaris_semester_result_publish (entity, is_published);
