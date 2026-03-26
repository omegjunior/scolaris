ALTER TABLE llx_scolaris_enrollment ADD UNIQUE INDEX uk_scolaris_enrollment (entity, fk_student, fk_academic_year);
ALTER TABLE llx_scolaris_enrollment ADD INDEX idx_scolaris_enrollment_student (fk_student);
ALTER TABLE llx_scolaris_enrollment ADD INDEX idx_scolaris_enrollment_year (fk_academic_year);
ALTER TABLE llx_scolaris_enrollment ADD INDEX idx_scolaris_enrollment_level (fk_level);
ALTER TABLE llx_scolaris_enrollment ADD INDEX idx_scolaris_enrollment_status (entity, registration_status);
