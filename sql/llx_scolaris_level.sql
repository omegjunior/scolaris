-- DROP TABLE llx_scolaris_level
CREATE TABLE llx_scolaris_level (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  code varchar(16) NOT NULL,
  label varchar(128) NOT NULL,
  cycle_code varchar(32) NOT NULL DEFAULT 'LICENCE',
  level_order smallint NOT NULL DEFAULT 1,
  credits_target decimal(10,2) NOT NULL DEFAULT 60.00,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
