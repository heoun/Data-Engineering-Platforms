/***********************************************
**                MSc ANALYTICS 
**     DATA ENGINEERING PLATFORMS (MSCA 31012)
** File:   DEP - DDL - Nutrition Data
** Desc:   Creating the Nutrition Data Schema
** Auth:   Han Jeon
** Date:   08/11/2019
** ALL RIGHTS RESERVED | DO NOT DISTRIBUTE
************************************************/
#creates the structure and DML puts the data 
#DDL - Data definition Language - DML Data Manipulation Language
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema nutrition
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `nutrition` DEFAULT CHARACTER SET latin1 ;
USE `nutrition` ;

-- -----------------------------------------------------
-- Table `nutrition`.`stores`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `nutrition`.`stores (
  `state` VARCHAR(45) NOT NULL,
  `county` VARCHAR(55) NOT NULL,
  `grocery_store_09` int(10) NOT NULL,
  `grocery_store_14` int(10) NOT NULL,
  `grocery_store_change` int(10) NOT NULL,
  `supercenter_09` int(10) NOT NULL,
  `supercenter_14` int(10) NOT NULL,
  `supercenter_change` int(10) NOT NULL,
  `convenience_store_09` int(10) not null,
  `convenience_store_14` int(10) not null,
  `specialized_store_09` int(10) not null,
  `specialized_store_change` int(10) not null,
  `WIC_08` int(10) not null,
  `WIC_12` int(10) not null,
  `WIC_change` int(10) not null,
  `SNAP_08` int(10) not null,
  `SNAP_12` int(10) not null,
  `SNAP_change` int(10) not null,
  PRIMARY KEY (`county`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `county` ON `nurition`.`stores` (`county` ASC);

