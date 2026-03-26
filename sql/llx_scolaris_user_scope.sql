-- DROP TABLE llx_scolaris_user_scope
CREATE TABLE llx_scolaris_user_scope (
  rowid integer AUTO_INCREMENT PRIMARY KEY,
  entity integer NOT NULL DEFAULT 1,
  fk_user integer NOT NULL,
  fk_academic_year integer NOT NULL DEFAULT 0,
  fk_semester integer NOT NULL DEFAULT 0,
  fk_course integer NOT NULL DEFAULT 0,
  can_read tinyint NOT NULL DEFAULT 0,
  can_enter_grade tinyint NOT NULL DEFAULT 0,
  can_validate tinyint NOT NULL DEFAULT 0,
  can_publish tinyint NOT NULL DEFAULT 0,
  can_generate_pdf tinyint NOT NULL DEFAULT 0,
  status smallint NOT NULL DEFAULT 1,
  date_creation datetime NULL,
  tms timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_user_author integer NULL,
  fk_user_modif integer NULL,
  import_key varchar(14)
) ENGINE=innodb;
