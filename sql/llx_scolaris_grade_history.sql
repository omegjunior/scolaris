-- DROP TABLE llx_scolaris_grade_history
CREATE TABLE llx_scolaris_grade_history (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_grade integer NOT NULL,
  action_code varchar(32) NOT NULL,
  old_score decimal(10,4) NULL,
  new_score decimal(10,4) NULL,
  old_absence_code varchar(16) NULL,
  new_absence_code varchar(16) NULL,
  old_status smallint NULL,
  new_status smallint NULL,
  reason text NULL,
  snapshot_before longtext NULL,
  snapshot_after longtext NULL,
  date_action datetime NOT NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_action integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
