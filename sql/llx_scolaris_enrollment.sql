-- DROP TABLE llx_scolaris_enrollment
CREATE TABLE llx_scolaris_enrollment (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_student integer NOT NULL,
  fk_academic_year integer NOT NULL,
  fk_level integer NOT NULL,
  group_code varchar(64) NULL,
  registration_status varchar(32) NOT NULL DEFAULT 'registered',
  is_repeating tinyint NOT NULL DEFAULT 0,
  date_registered datetime NULL,
  date_cancelled datetime NULL,
  note text NULL,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
