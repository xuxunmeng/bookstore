-- MySQL Script generated by MySQL Workbench
-- Sun Nov 25 18:14:11 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BOOKSTORE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BOOKSTORE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BOOKSTORE` DEFAULT CHARACTER SET utf8 ;
USE `BOOKSTORE` ;

-- -----------------------------------------------------
-- Table `BOOKSTORE`.`user_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`user_permissions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BOOKSTORE`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enterprise` INT UNSIGNED NULL,
  `store` INT UNSIGNED NULL,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `salt` VARCHAR(10) NULL,
  `is_admin` TINYINT NOT NULL DEFAULT 0,
  `permission` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`username` ASC),
  INDEX `permission_idx` (`permission` ASC),
  CONSTRAINT `enterprise`
    FOREIGN KEY (`enterprise`)
    REFERENCES `BOOKSTORE`.`enterprises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_store`
    FOREIGN KEY (`store`)
    REFERENCES `BOOKSTORE`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `permission`
    FOREIGN KEY (`permission`)
    REFERENCES `BOOKSTORE`.`user_permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BOOKSTORE`.`enterprises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`enterprises` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0 DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BOOKSTORE`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`stores` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `store_code` VARCHAR(20) NOT NULL,
  `config` JSON,
  `enterprise` INT UNSIGNED NOT NULL,
  `addr` VARCHAR(45) NULL,
  `last_modifier` INT UNSIGNED NULL,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `enterprises_idx` (`enterprise` ASC),
  CONSTRAINT `enterprises`
    FOREIGN KEY (`enterprise`)
    REFERENCES `BOOKSTORE`.`enterprises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BOOKSTORE`.`terminal_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`terminal_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BOOKSTORE`.`terminals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`terminals` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `note` VARCHAR(45) NULL,
  `type` INT UNSIGNED NULL,
  `store` INT UNSIGNED NULL,
  `view_config` INT UNSIGNED NULL,
  `last_modifier` INT UNSIGNED NULL,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `store_idx` (`store` ASC),
  INDEX `type_idx` (`type` ASC),
  CONSTRAINT `view_config`
    FOREIGN KEY (`view_config`)
    REFERENCES `BOOKSTORE`.`view_configs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `store`
    FOREIGN KEY (`store`)
    REFERENCES `BOOKSTORE`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `type`
    FOREIGN KEY (`type`)
    REFERENCES `BOOKSTORE`.`terminal_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Placeholder table for view `BOOKSTORE`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOKSTORE`.`view_configs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` INT UNSIGNED NULL,
  `name` VARCHAR(45) NULL,
  `note` VARCHAR(45) NULL,
  `store` INT UNSIGNED NULL,
  `content` JSON,
  `deleted` TINYINT UNSIGNED NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `note_UNIQUE` (`note` ASC),
  CONSTRAINT `view_type`
    FOREIGN KEY (`type`)
    REFERENCES `BOOKSTORE`.`terminal_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `view_store`
    FOREIGN KEY (`store`)
    REFERENCES `BOOKSTORE`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- View `BOOKSTORE`.`view1`
-- -----------------------------------------------------
USE `BOOKSTORE`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
