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
  `grocery_store_09` int(10) NOT NULL,
  `grocery_store_14` int(10) NOT NULL,
  `supercenter_09` int(10) NOT NULL,
  `supercenter_14` int(10) NOT NULL,
  `


CREATE TABLE IF NOT EXISTS `sakila_snowflake`.`dim_actor` (
  `actor_key` INT(10) NOT NULL AUTO_INCREMENT,
  `actor_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `actor_id` INT(10) NOT NULL,
  `actor_last_name` VARCHAR(45) NOT NULL,
  `actor_first_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`actor_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `dim_actor_last_update` ON `sakila_snowflake`.`dim_actor` (`actor_last_update` ASC);






Divided into Grocery Stores / Supercenters / Convenience Stores / Specialized Stores / WIC / SNAP
Information contains 2009 / 2014 / % change by county / 
Can use the percentage change to measure the increase or decrease in wealth from 2009 to 2014. Some assumptions will need to be made on what class of wealth would be willing to shop where. For ex. SNAP/WIC would indicate the poor and has this increased or decreased since 2009.
2009 is right after 2008 so it should be interesting to see how people have changed and whether there has been improvements in shopping habits and wealth patterns when compared to access and sociodemographic data.




