-- DROP TABLE llx_scolaris_grade
CREATE TABLE llx_scolaris_grade (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_assessment integer NOT NULL,
  fk_student integer NOT NULL,
  fk_enrollment integer NOT NULL,
  score decimal(10,4) NULL,
  absence_code varchar(16) NULL,
  is_excused tinyint NOT NULL DEFAULT 0,
  status smallint NOT NULL DEFAULT 0,
  is_published tinyint NOT NULL DEFAULT 0,
  entry_comment text NULL,
  validation_comment text NULL,
  date_creation datetime NULL,
  date_modification datetime NULL,
  date_validated datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  fk_user_valid integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
