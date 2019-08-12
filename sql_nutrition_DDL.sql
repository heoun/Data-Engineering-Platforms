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
  `grocery_store_pch` int(10) NOT NULL,
  `grocery_store_09_1000` int(10) NOT NULL,
  `grocery_store_14_1000` int(10) NOT NULL,
  `grocery_store_1000_pch` int(10) NOT NULL,
  `supercenter_09` int(10) NOT NULL,
  `supercenter_14` int(10) NOT NULL,
  `supercenter_pch` int(10) NOT NULL,
  `supercenter_09_1000` int(10) NOT NULL,
  `supercenter_14_1000` int(10) NOT NULL,
  `supercenter_1000_pch` int(10) NOT NULL,
  `convenience_store_09` int(10) not null,
  `convenience_store_14` int(10) not null,
  `convenience_store_09_1000` int(10) NOT NULL,
  `convenience_store_14_1000` int(10) NOT NULL,
  `convenience_store_1000_pch` int(10) NOT NULL,
  `specialized_store_09` int(10) not null,
  `specialized_store_pch` int(10) not null,
  `specialized_store_09_1000` int(10) NOT NULL,
  `specialized_store_14_1000` int(10) NOT NULL,
  `specialized_store_1000_pch` int(10) NOT NULL,
  `WIC_08` int(10) not null,
  `WIC_12` int(10) not null,
  `WIC_pch` int(10) not null,
  `WIC_09_1000` int(10) NOT NULL,
  `WIC_14_1000` int(10) NOT NULL,
  `WIC_1000_pch` int(10) NOT NULL,
  `SNAP_08` int(10) not null,
  `SNAP_12` int(10) not null,
  `SNAP_pch` int(10) not null,
  `SNAP_09_1000` int(10) NOT NULL,
  `SNAP_14_1000` int(10) NOT NULL,
  `SNAP_1000_pch` int(10) NOT NULL,
  PRIMARY KEY (`county`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `county` ON `nurition`.`stores` (`county` ASC);

#1000 columns refer  to restaurants per 1,000 pop
CREATE TABLE IF NOT EXISTS `restaurants` (
  `county_key` INT(10) NOT NULL,
  `fast_food_09_count` INT(10) ,
  `fast_food_14_count` INT(10),
  `fast_food_pch_09_14` DECIMAL(6,1),
  `fast_food_09_1000` DECIMAL(6,2),
  `fast_food_14_1000` DECIMAL(6,2),
  `fast_food_09_14_pch1000` DECIMAL(6,1),
  `full_service_09_count` INT(10),
  `full_service_14_count` INT(10),
  `full_service_pch_09_14` DECIMAL(6,1),
  `full_service_09_1000` DECIMAL(6,2),
  `full_service_14_1000` DECIMAL(6,2),
  `full_service_09_14_pch1000` DECIMAL(6,1),
  PRIMARY KEY (`county_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

# with this when if we chose to use it may be useful to have a total column as well which we would need the pop*per_capita
CREATE TABLE IF NOT EXISTS `restaurant_expenditures` (
  `county_key` INT(10) NOT NULL,
  `fast_food_07_exp_per_capita` DECIMAL(10,2),
  `fast_food_12_exp_per_capita` DECIMAL (10,2),
  `full_service_07_exp_per_capita` DECIMAL (10,2),
  `full_service_12_exp_per_capita` DECIMAL (10,2),
  PRIMARY KEY (`county_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

#average means 3 year average
CREATE TABLE IF NOT EXISTS `food_insecurity` (
  `county_key` INT(10) NOT NULL,
  `household_avg_10_12` DECIMAL(4,1),
  `household_avg_13_15` DECIMAL(4,1),
  `household_avg_pch` DECIMAL(4,1),
  `household_verylow_avg_10_12` DECIMAL(4,1),
  `household_verylow_avg_13_15` DECIMAL(4,1),
  `household_verylow_avg_pch` DECIMAL(4,1),
  `child_avg_01_07` DECIMAL(4,1),
  `child_avg_03_11` DECIMAL(4,1),
  PRIMARY KEY (`county_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

# prices are compared to national average, so it is an index
CREATE TABLE IF NOT EXISTS `food_prices` (
  `county_key` INT(10) NOT NULL,
  `price_milk_to_national_10` DECIMAL(6,4),
  `price_soda_to_national_10` DECIMAL(6,4),
  `price_milk_soda_to_national_10` DECIMAL(6,4),
  PRIMARY KEY (`county_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `food_taxes` (
  `county_key` INT(10) NOT NULL,
  `soda_stores_14` DECIMAL(6,2),
  `soda_vending_14` DECIMAL(6,2),
  `chips_pretzels_stores_14` DECIMAL(6,2),
  `chips_pretzels_vending_14` DECIMAL(6,2),
  `general_food_stores_14` DECIMAL(6,2),
  PRIMARY KEY (`county_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

#going to update the assistance table with better names in next commit
CREATE TABLE IF NOT EXISTS `assistance` (
  `county_key` INT(8) NOT NULL, #FIPS
  `State` VARCHAR(255) NOT NULL,
  `County` VARCHAR(255) NOT NULL,
  `REDEMP_SNAPS12` FLOAT NOT NULL,
  `REDEMP_SNAPS16` FLOAT NULL,
  `PCH_REDEMP_SNAPS_12_16` FLOAT NULL,
  `PCT_SNAP12` FLOAT NULL,
  `PCT_SNAP16` FLOAT NULL,
  `PCH_SNAP_12_16` FLOAT NULL,
  `PC_SNAPBEN10` FLOAT NULL,
  `PC_SNAPBEN15` FLOAT NULL,
  `PCH_PC_SNAPBEN_10_15` FLOAT NULL,
  `SNAP_PART_RATE08` FLOAT NULL,
  `SNAP_PART_RATE13` FLOAT NULL,
  `SNAP_OAPP09` FLOAT NULL,
  `SNAP_OAPP16` FLOAT NULL,
  `SNAP_CAP09` FLOAT NULL,
  `SNAP_CAP16` FLOAT NULL,
  `SNAP_BBCE09` FLOAT NULL,
  `SNAP_BBCE16` FLOAT NULL,
  `SNAP_REPORTSIMPLE09` FLOAT NULL,
  `SNAP_REPORTSIMPLE16` FLOAT NULL,
  `PCT_NSLP09` FLOAT NULL,
  `PCT_NSLP15` FLOAT NULL,
  `PCH_NSLP_09_15` FLOAT NULL,
  `PCT_FREE_LUNCH09` FLOAT NULL,
  `PCT_FREE_LUNCH14` FLOAT NULL,
  `PCT_REDUCED_LUNCH09` FLOAT NULL,
  `PCT_REDUCED_LUNCH14` FLOAT NULL,
  `PCT_SBP09` FLOAT NULL,
  `PCT_SBP15` FLOAT NULL,
  `PCH_SBP_09_15` FLOAT NULL,
  `PCT_SFSP09` FLOAT NULL,
  `PCT_SFSP15` FLOAT NULL,
  `PCH_SFSP_09_15` FLOAT NULL,
  `PC_WIC_REDEMP08` FLOAT NULL,
  `PC_WIC_REDEMP12` FLOAT NULL,
  `PCH_PC_WIC_REDEMP_08_12` FLOAT NULL,
  `REDEMP_WICS08` FLOAT NULL,
  `REDEMP_WICS12` FLOAT NULL,
  `PCH_REDEMP_WICS_08_12` FLOAT NULL,
  `PCT_WIC09` FLOAT NULL,
  `PCT_WIC15` FLOAT NULL,
  `PCH_WIC_09_15` FLOAT NULL,
  `PCT_CACFP09` FLOAT NULL,
  `PCT_CACFP15` FLOAT NULL,
  `PCH_CACFP_09_15` FLOAT NULL,
  `FDPIR12` INT(8) NULL,
  PRIMARY KEY (`county_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `health` (
  `county_key` INT(8) NOT NULL, #FIPS
  `State` VARCHAR(255) NOT NULL,
  `County` VARCHAR(255) NOT NULL,
  `adult_diabetes_rate_08` FLOAT NULL, #PCT_DIABETES_ADULTS08
  `adult_diabetes_rate_13` FLOAT NULL, #PCT_DIABETES_ADULTS13
  `adult_obesity_rate_08` FLOAT NULL, #PCT_OBESE_ADULTS08
  `adult_obesity_rate_13` FLOAT NULL, #PCT_OBESE_ADULTS13
  `highscoolers_phys_active_rate_15` FLOAT NULL, #PCT_HSPA15
  `rec_fit_facilities_09` INT(8) NULL, #RECFAC09
  `rec_fit_facilities_14` INT(8) NULL, #RECFAC14
  `rec_fit_facilities_pctchange_09-14`, #PCH_RECFAC_09_14
  `rec_fit_facilities_perM_09` INT(8) NULL, #RECFACPTH09
  `rec_fit_facilities_perM_14` INT(8) NULL, #RECFACPTH14
  `rec_fit_facilities_perM_pctchange_09-14` NULL,#PCH_RECFACPTH_09_14
  PRIMARY KEY (`county_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;