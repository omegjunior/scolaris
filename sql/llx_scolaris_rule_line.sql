-- DROP TABLE llx_scolaris_rule_line
CREATE TABLE llx_scolaris_rule_line (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_rule_profile integer NOT NULL,
  target_type varchar(32) NOT NULL,
  target_code varchar(32) NOT NULL,
  weight decimal(20,8) NOT NULL DEFAULT 1.00000000,
  options_payload longtext NULL,
  display_order smallint NOT NULL DEFAULT 1,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
