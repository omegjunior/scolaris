-- DROP TABLE llx_scolaris_typology
CREATE TABLE llx_scolaris_typology (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  code varchar(16) NOT NULL,
  label varchar(255) NOT NULL,
  short_label varchar(64) NULL,
  display_order smallint NOT NULL DEFAULT 1,
  counts_for_average tinyint NOT NULL DEFAULT 1,
  counts_for_credits tinyint NOT NULL DEFAULT 1,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
