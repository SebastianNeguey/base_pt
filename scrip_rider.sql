-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_proyect
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_proyect
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_proyect` DEFAULT CHARACTER SET utf8 ;
USE `bd_proyect` ;

-- -----------------------------------------------------
-- Table `bd_proyect`.`talla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`talla` (
  `id_talla` INT NOT NULL AUTO_INCREMENT,
  `nombre_talla` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_talla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`tipo` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`equipo` (
  `id_equipo` INT NOT NULL AUTO_INCREMENT,
  `nombre_equipo` VARCHAR(100) NOT NULL,
  `cantidad_equipo` INT NOT NULL,
  `id_talla` INT NOT NULL,
  `id_tipo` INT NOT NULL,
  PRIMARY KEY (`id_equipo`),
  INDEX `fk_equipo_talla1_idx` (`id_talla` ASC),
  INDEX `fk_equipo_tipo1_idx` (`id_tipo` ASC),
  CONSTRAINT `fk_equipo_talla1`
    FOREIGN KEY (`id_talla`)
    REFERENCES `bd_proyect`.`talla` (`id_talla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_tipo1`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `bd_proyect`.`tipo` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `descripcion_estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`sesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`sesion` (
  `id_sesion` INT NOT NULL AUTO_INCREMENT,
  `contra_sesion` VARCHAR(50) NOT NULL,
  `correo_sesion` VARCHAR(50) NOT NULL,
  `id_tipo` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_sesion`),
  INDEX `fk_sesion_tipo_idx` (`id_tipo` ASC),
  INDEX `fk_sesion_estado1_idx` (`id_estado` ASC),
  CONSTRAINT `fk_sesion_tipo`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `bd_proyect`.`tipo` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sesion_estado1`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd_proyect`.`estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre_cliente` VARCHAR(50) NOT NULL,
  `apellidop_cliente` VARCHAR(50) NOT NULL,
  `apellidom_cliente` VARCHAR(50) NOT NULL,
  `rut_cliente` VARCHAR(10) NOT NULL,
  `numero_cliente` VARCHAR(12) NOT NULL,
  `nacimiento_cliente` DATE NULL,
  `id_sesion` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_sesion1_idx` (`id_sesion` ASC),
  CONSTRAINT `fk_cliente_sesion1`
    FOREIGN KEY (`id_sesion`)
    REFERENCES `bd_proyect`.`sesion` (`id_sesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`admin` (
  `id_admin` INT NOT NULL,
  `nombre_admin` VARCHAR(50) NOT NULL,
  `apelldiop_admin` VARCHAR(50) NOT NULL,
  `apellidom_admin` VARCHAR(50) NOT NULL,
  `rut_admin` VARCHAR(10) NOT NULL,
  `id_sesion` INT NOT NULL,
  PRIMARY KEY (`id_admin`),
  INDEX `fk_admin_sesion1_idx` (`id_sesion` ASC),
  CONSTRAINT `fk_admin_sesion1`
    FOREIGN KEY (`id_sesion`)
    REFERENCES `bd_proyect`.`sesion` (`id_sesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`instructor` (
  `id_instructor` INT NOT NULL,
  `nombre_instructor` VARCHAR(50) NULL,
  `apellidop_instrucotor` VARCHAR(50) NULL,
  `apellidom_instrutor` VARCHAR(50) NULL,
  `rut_instructor` VARCHAR(10) NULL,
  `id_sesion` INT NOT NULL,
  PRIMARY KEY (`id_instructor`),
  INDEX `fk_instructor_sesion1_idx` (`id_sesion` ASC),
  CONSTRAINT `fk_instructor_sesion1`
    FOREIGN KEY (`id_sesion`)
    REFERENCES `bd_proyect`.`sesion` (`id_sesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`clase` (
  `id_clase` INT NOT NULL AUTO_INCREMENT,
  `hora_clase` VARCHAR(5) NULL,
  `horafinal_clase` VARCHAR(5) NULL,
  `fecha_clase` DATE NULL,
  `id_instructor` INT NOT NULL,
  `id_tipo` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_clase`),
  INDEX `fk_clase_instructor1_idx` (`id_instructor` ASC),
  INDEX `fk_clase_tipo1_idx` (`id_tipo` ASC),
  INDEX `fk_clase_estado1_idx` (`id_estado` ASC),
  CONSTRAINT `fk_clase_instructor1`
    FOREIGN KEY (`id_instructor`)
    REFERENCES `bd_proyect`.`instructor` (`id_instructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clase_tipo1`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `bd_proyect`.`tipo` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clase_estado1`
    FOREIGN KEY (`id_estado`)
    REFERENCES `bd_proyect`.`estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`clase_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`clase_cliente` (
  `id_clase` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_equipo` INT NOT NULL,
  PRIMARY KEY (`id_clase`, `id_cliente`),
  INDEX `fk_clase_has_cliente_cliente1_idx` (`id_cliente` ASC),
  INDEX `fk_clase_has_cliente_clase1_idx` (`id_clase` ASC),
  INDEX `fk_clase_cliente_equipo1_idx` (`id_equipo` ASC),
  CONSTRAINT `fk_clase_has_cliente_clase1`
    FOREIGN KEY (`id_clase`)
    REFERENCES `bd_proyect`.`clase` (`id_clase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clase_has_cliente_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `bd_proyect`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clase_cliente_equipo1`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `bd_proyect`.`equipo` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`valor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`valor` (
  `id_valor` INT NOT NULL AUTO_INCREMENT,
  `nota` INT NOT NULL,
  PRIMARY KEY (`id_valor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_proyect`.`nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_proyect`.`nota` (
  `instructor_id_instructor` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `descripcion_nota` VARCHAR(45) NULL,
  `id_valor` INT NOT NULL,
  PRIMARY KEY (`instructor_id_instructor`, `cliente_id_cliente`),
  INDEX `fk_instructor_has_cliente_cliente1_idx` (`cliente_id_cliente` ASC),
  INDEX `fk_instructor_has_cliente_instructor1_idx` (`instructor_id_instructor` ASC),
  INDEX `fk_nota_valor1_idx` (`id_valor` ASC),
  CONSTRAINT `fk_instructor_has_cliente_instructor1`
    FOREIGN KEY (`instructor_id_instructor`)
    REFERENCES `bd_proyect`.`instructor` (`id_instructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instructor_has_cliente_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `bd_proyect`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_valor1`
    FOREIGN KEY (`id_valor`)
    REFERENCES `bd_proyect`.`valor` (`id_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
