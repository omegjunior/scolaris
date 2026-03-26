ALTER TABLE llx_scolaris_student ADD UNIQUE INDEX uk_scolaris_student_number (entity, student_number);
ALTER TABLE llx_scolaris_student ADD INDEX idx_scolaris_student_user (fk_user);
ALTER TABLE llx_scolaris_student ADD INDEX idx_scolaris_student_status (entity, status);
ALTER TABLE llx_scolaris_student ADD INDEX idx_scolaris_student_name (lastname, firstname);
