-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio_db` DEFAULT CHARACTER SET utf8 ;
USE `portfolio_db` ;

-- -----------------------------------------------------
-- Table `portfolio_db`.`card_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`card_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`card` (
  `card_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`card_id`, `type_id`),
  INDEX `fk_card_card_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_card_card_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `portfolio_db`.`card_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`date_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`date_type` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`date` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_1` DATE NOT NULL,
  `date_2` DATE NULL,
  `card_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`id`, `card_id`, `type_id`),
  INDEX `fk_date_card_idx` (`card_id` ASC) VISIBLE,
  INDEX `fk_date_date_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_date_card`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_date_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `portfolio_db`.`date_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`image_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`image_type` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `path` VARCHAR(45) NOT NULL,
  `card_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`id`, `card_id`, `type_id`),
  INDEX `fk_image_card1_idx` (`card_id` ASC) VISIBLE,
  INDEX `fk_image_image_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_image_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_image_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `portfolio_db`.`image_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`educ_exp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`educ_exp` (
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `institution` VARCHAR(45) NOT NULL,
  `has_institution_image` TINYINT NOT NULL,
  `card_id` INT NOT NULL,
  INDEX `fk_educ_exp_card1_idx` (`card_id` ASC) VISIBLE,
  PRIMARY KEY (`card_id`),
  CONSTRAINT `fk_educ_exp_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`hard_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`hard_skill` (
  `value` INT NOT NULL,
  `has_background` TINYINT NOT NULL,
  `card_id` INT NOT NULL,
  INDEX `fk_hard_skill_card1_idx` (`card_id` ASC) VISIBLE,
  PRIMARY KEY (`card_id`),
  CONSTRAINT `fk_hard_skill_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`point_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`point_type` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`point`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`point` (
  `id` INT NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `type_id` INT NOT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`id`, `type_id`, `card_id`),
  INDEX `fk_point_point_type1_idx` (`type_id` ASC) VISIBLE,
  INDEX `fk_point_hard_skill1_idx` (`card_id` ASC) VISIBLE,
  CONSTRAINT `fk_point_point_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `portfolio_db`.`point_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_point_hard_skill1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`hard_skill` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`soft_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`soft_skill` (
  `description` VARCHAR(255) NOT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`card_id`),
  CONSTRAINT `fk_soft_skill_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`sub_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`sub_skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `value` INT NOT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`id`, `card_id`),
  INDEX `fk_sub_skill_soft_skill1_idx` (`card_id` ASC) VISIBLE,
  CONSTRAINT `fk_sub_skill_soft_skill1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`soft_skill` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`project` (
  `description` VARCHAR(255) NOT NULL,
  `has_images` TINYINT NOT NULL,
  `page_link` VARCHAR(255) NOT NULL,
  `gitHub_link` VARCHAR(255) NOT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`card_id`),
  CONSTRAINT `fk_project_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`owner_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`owner_info` (
  `description` VARCHAR(255) NOT NULL,
  `has_banner` TINYINT NOT NULL,
  `has_photo` TINYINT NOT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`card_id`),
  CONSTRAINT `fk_owner_info_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `portfolio_db`.`card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_db`.`administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_db`.`administrator` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Inserting data - start
-- -----------------------------------------------------

INSERT INTO `portfolio_db`.`administrator` VALUES
	('A','123');

INSERT INTO `portfolio_db`.`card_type` VALUES
	(0, 'owner_info'),
	(0, 'educ_exp'),
	(0, 'hard_skill'),
	(0, 'soft_skill'),
	(0, 'project');

INSERT INTO `portfolio_db`.`card` VALUES
	(1, 'Full Stack Developer Jr', 1),
	(2, 'Certificado de programador', 2),
	(3, 'Estudios secundarios', 2),
	(4, 'FrontEnd - JavaScript y TypeScript', 3),
	(5, 'FrontEnd - HTML, CSS y Bootstrap', 3),
	(6, 'FrontEnd - Angular', 3),
	(7, 'Eficiencia y Eficacia', 4),
	(8, 'Trabajo en equipo', 4),
	(9, 'Inglés (idioma)', 4),
	(10, 'Portfolio', 5);

INSERT INTO `portfolio_db`.`owner_info` VALUES
	("Mi nombre es Alan Duhalde, programador en formación, instruido bajo la tutoría ofrecida por el 'Argentina Programa', aún sin especialización, pero con capacidades de diseñar y programar FrontEnd, de manera como aquí se contempla.", 1, 1, 1);

INSERT INTO `portfolio_db`.`educ_exp` VALUES
	('Full Stack Developer Jr', NULL, 'INTI', 1, 2),
	('Titulo secundario de Bachiller en Economía y Administración', NULL, 'ICTS', 1, 3);

INSERT INTO `portfolio_db`.`hard_skill` VALUES
	(75, 1, 4),
	(75, 1, 5),
	(60, 1, 6);

INSERT INTO `portfolio_db`.`point_type` VALUES
	(1, 'positive'),
	(2, 'negative');

INSERT INTO `portfolio_db`.`point` VALUES
	(1, "Funciones básicas", 1, 4),
	(2, "Programación Orientada a Objetos", 1, 4),
	(3, "Tipado estático (Ts)", 1, 4),
	(4, "Uso de elemento Canvas", 1, 4),
	(5, "Manejo básico de Elementos del DOM", 1, 4),
	(6, "Peticiones", 2, 4),
	(7, "Conexiones a Internet, servidores, etc", 2, 4),
	(8, "Diseño estático", 1, 5),
	(9, "Uso básico de CSS", 1, 5),
	(10, "Uso básico de Bootstrap", 1, 5),
	(11, "Diseños responsivos", 1, 5),
	(12, "SEO", 2, 5),
	(13, "Poco acostumbrado al uso de librerias y/o frameworks", 2, 5),
	(14, "Aprendizaje rápido", 1, 6),
	(15, "Falta de costumbre para \"generalizar\"", 2, 6);

INSERT INTO `portfolio_db`.`soft_skill` VALUES
	("Cuando me pongo a pensar...", 7),
	("En la mayoría de las ocaciónes...", 8),
	("Puedo leer, interpretar y escribir...", 9);

INSERT INTO `portfolio_db`.`sub_skill` VALUES
	(1, 75, 7),
	(2, 65, 7),
	(3, 55, 7),
	(4, 65, 7),
	(5, 70, 7),
	(6, 50, 8),
	(7, 70, 8),
	(8, 75, 8),
	(9, 65, 8),
	(10, 50, 9),
	(11, 65, 9),
	(12, 20, 9);

INSERT INTO `portfolio_db`.`project` VALUES
	("Segunda versión de mi Portfolio personal, creado utilizando el framework de Angular...", 1, "/", "https://github.com/AlanDuh/portfolio-FrontEnd_Angular", 10);

INSERT INTO `portfolio_db`.`date_type` VALUES
	(1, 'only-one'),
	(2, 'only-start'),
	(3, 'only-end'),
	(4, 'both');

INSERT INTO `portfolio_db`.`date` VALUES
	(1, '2022-11-12', NULL, 2, 2),
	(2, '2021-12-10', NULL, 3, 3),
	(3, '2023-02-21', NULL, 10, 1);

INSERT INTO `portfolio_db`.`image_position` VALUES
	(1, 'primary'),
	(2, 'secondary');

INSERT INTO `portfolio_db`.`image` VALUES
	(1, 'image-1', '/', 1, 1),
	(2, 'image-2', '/', 1, 2),
	(3, 'image-3', '/', 2, 1),
	(4, 'image-4', '/', 3, 1),
	(5, 'image-5', '/', 4, 1),
	(6, 'image-6', '/', 5, 1),
	(7, 'image-7', '/', 6, 1),
	(8, 'image-8', '/', 10, 1),
	(9, 'image-9', '/', 10, 1),
	(10, 'image-10', '/', 10, 1),
	(11, 'image-11', '/', 10, 1);

-- -----------------------------------------------------
-- Inserting data - end
-- -----------------------------------------------------


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
