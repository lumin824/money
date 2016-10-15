-- MySQL Script generated by MySQL Workbench
-- Sun Oct 16 00:27:54 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema money
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema money
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `money` DEFAULT CHARACTER SET utf8 ;
USE `money` ;

-- -----------------------------------------------------
-- Table `money`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `money`.`user` ;

CREATE TABLE IF NOT EXISTS `money`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) NOT NULL,
  `mobile` VARCHAR(255) NOT NULL,
  `login_time` BIGINT(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `mobile_UNIQUE` (`mobile` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10000;


-- -----------------------------------------------------
-- Table `money`.`loan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `money`.`loan` ;

CREATE TABLE IF NOT EXISTS `money`.`loan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `mobile` VARCHAR(255) NULL,
  `idno` VARCHAR(255) NULL,
  `name` VARCHAR(255) NULL,
  `money` VARCHAR(255) NULL,
  `total_stage` VARCHAR(255) NULL,
  `start_time` BIGINT(20) NULL,
  `end_time` BIGINT(20) NULL,
  `icloud` VARCHAR(255) NULL,
  `remark` VARCHAR(255) NULL,
  `update_time` BIGINT(20) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loan__user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `money`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10000;


-- -----------------------------------------------------
-- Table `money`.`loan_file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `money`.`loan_file` ;

CREATE TABLE IF NOT EXISTS `money`.`loan_file` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `hash` VARCHAR(45) NULL,
  `loan_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loan_file__loan_id`
    FOREIGN KEY (`loan_id`)
    REFERENCES `money`.`loan` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10000;


-- -----------------------------------------------------
-- Table `money`.`loan_stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `money`.`loan_stage` ;

CREATE TABLE IF NOT EXISTS `money`.`loan_stage` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `loan_id` INT NULL,
  `stage` VARCHAR(45) NULL,
  `lixi_1` DECIMAL(8,2) NULL,
  `lixi_2` DECIMAL(8,2) NULL,
  `benjin_1` DECIMAL(8,2) NULL,
  `benjin_2` DECIMAL(8,2) NULL,
  `end_time` BIGINT(20) NULL,
  `lixi` TINYINT(1) NULL,
  `benjin` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loan_stage__loan_id`
    FOREIGN KEY (`loan_id`)
    REFERENCES `money`.`loan` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10000;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;