-- DROP TABLE llx_scolaris_semester
CREATE TABLE llx_scolaris_semester (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_level integer NOT NULL,
  code varchar(16) NOT NULL,
  label varchar(128) NOT NULL,
  semester_number smallint NOT NULL,
  credits_target decimal(10,2) NOT NULL DEFAULT 30.00,
  display_order smallint NOT NULL DEFAULT 1,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
