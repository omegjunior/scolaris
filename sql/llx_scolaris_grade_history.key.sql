ALTER TABLE llx_scolaris_grade_history ADD INDEX idx_scolaris_grade_history_grade (fk_grade);
ALTER TABLE llx_scolaris_grade_history ADD INDEX idx_scolaris_grade_history_action (action_code);
ALTER TABLE llx_scolaris_grade_history ADD INDEX idx_scolaris_grade_history_date (date_action);
