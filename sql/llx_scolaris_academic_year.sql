-- DROP TABLE llx_scolaris_academic_year
CREATE TABLE llx_scolaris_academic_year (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  code varchar(32) NOT NULL,
  label varchar(128) NOT NULL,
  date_start date NOT NULL,
  date_end date NOT NULL,
  is_current tinyint NOT NULL DEFAULT 0,
  status smallint NOT NULL DEFAULT 1,
  note text,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
