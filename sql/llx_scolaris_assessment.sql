-- DROP TABLE llx_scolaris_assessment
CREATE TABLE llx_scolaris_assessment (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_course integer NOT NULL,
  fk_academic_year integer NOT NULL,
  code varchar(32) NOT NULL,
  label varchar(255) NOT NULL,
  assessment_type varchar(32) NOT NULL,
  session_type varchar(32) NOT NULL DEFAULT 'normal',
  assessment_order smallint NOT NULL DEFAULT 1,
  weight decimal(20,8) NOT NULL DEFAULT 1.00000000,
  max_score decimal(10,2) NOT NULL DEFAULT 20.00,
  date_assessment date NULL,
  status smallint NOT NULL DEFAULT 0,
  fk_user_valid integer NULL,
  date_validated datetime NULL,
  note text NULL,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
