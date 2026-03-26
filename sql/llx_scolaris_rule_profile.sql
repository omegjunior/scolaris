-- DROP TABLE llx_scolaris_rule_profile
CREATE TABLE llx_scolaris_rule_profile (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  code varchar(32) NOT NULL,
  label varchar(255) NOT NULL,
  description text NULL,
  grading_scale decimal(10,2) NOT NULL DEFAULT 20.00,
  pass_mark decimal(10,2) NOT NULL DEFAULT 10.00,
  credit_rule varchar(32) NOT NULL DEFAULT 'per_course',
  makeup_rule varchar(32) NOT NULL DEFAULT 'replace',
  compensation_rule varchar(32) NOT NULL DEFAULT 'none',
  rule_payload longtext NULL,
  is_default tinyint NOT NULL DEFAULT 0,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
