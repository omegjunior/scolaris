-- DROP TABLE llx_scolaris_course_assignment
CREATE TABLE llx_scolaris_course_assignment (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_course integer NOT NULL,
  fk_academic_year integer NOT NULL,
  fk_user integer NOT NULL,
  role_code varchar(32) NOT NULL DEFAULT 'teacher',
  date_start date NULL,
  date_end date NULL,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
