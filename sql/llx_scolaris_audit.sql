-- DROP TABLE llx_scolaris_audit
CREATE TABLE llx_scolaris_audit (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  object_type varchar(64) NOT NULL,
  fk_object integer NOT NULL,
  action_code varchar(32) NOT NULL,
  label varchar(255) NULL,
  old_values longtext NULL,
  new_values longtext NULL,
  reason text NULL,
  ip_address varchar(64) NULL,
  user_agent varchar(255) NULL,
  date_action datetime NOT NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_actor integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
