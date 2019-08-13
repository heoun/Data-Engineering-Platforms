/***********************************************
**                MSc ANALYTICS 
**     DATA ENGINEERING PLATFORMS (MSCA 31012)
** File:   DEP - DDL - Nutrition Data
** Desc:   Creating the Nutrition Data Schema
** Auth:   Han Jeon, Patrick Butler, Laura Burns, Rhys Chua, Roquiya Sayeq 
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
CREATE TABLE IF NOT EXISTS `county` (
  `fips` INT(6),
  `state` VARCHAR(45) NOT NULL,
  `county` VARCHAR(45) NOT NULL,
  `2010_census_population` INT(11),
  `population_estimate_2011` INT(11),
  `population_estimate_2012` INT(11),
  `population_estimate_2013` INT(11),
  `population_estimate_2014` INT(11),
  `population_estimate_2015` INT(11),
  `population_estimate_2016` INT(11),
  PRIMARY KEY  (`fips`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `state` (
    `state_fips` SMALLINT(6),
    `state` VARCHAR(45),
    `wic_participants_fy_2009` INT(11),
    `wic_participants_fy_2011` INT(11),
    `wic_participants_fy_2012` INT(11),
    `wic_participants_fy_2013` INT(11),
    `wic_participants_fy_2014` INT(11),
    `wic_participants_fy_2015` INT(11),
    `national_school_lunch_program_participants_fy_2009` INT(11),
    `national_school_lunch_program_participants_fy_2011` INT(11),
    `national_school_lunch_program_participants_fy_2012` INT(11),
    `national_school_lunch_program_participants_fy_2013` INT(11),
    `national_school_lunch_program_participants_fy_2014` INT(11),
    `national_school_lunch_program_participants_fy_2015` INT(11),
    `school_breakfast_program_participants_fy_2009` INT(11),
    `school_breakfast_program_participants_fy_2011` INT(11),
    `school_breakfast_program_participants_fy_2012` INT(11),
    `school_breakfast_program_participants_fy_2013` INT(11),
    `school_breakfast_program_participants_fy_2014` INT(11),
    `school_breakfast_program_participants_fy_2015` INT(11),
    `child_adult_care_participants_fy_2009` INT(11),
    `child_adult_care_participants_fy_2011` INT(11),
    `child_adult_care_participants_fy_2012` INT(11),
    `child_adult_care_participants_fy_2013` INT(11),
    `child_adult_care_participants_fy_2014` INT(11),
    `child_adult_care_participants_fy_2015` INT(11),
    `summer_food_participants_fy_2009` INT(11),
    `summer_food_participants_fy_2011` INT(11),
    `summer_food_participants_fy_2012` INT(11),
    `summer_food_participants_fy_2013` INT(11),
    `summer_food_participants_fy_2014` INT(11),
    `summer_food_participants_fy_2015` INT(11),
    `state_population_2009` INT(11),
    `state_population_2010` INT(11),
    `state_population_2011` INT(11),
    `state_population_2012` INT(11),
    `state_population_2013` INT(11),
    `state_population_2014` INT(11),
    `state_population_2015` INT(11),
    `state_population_2016` INT(11),
  PRIMARY KEY (`state_fips`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `nutrition`.`stores` (
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
  `rec_fit_facilities_pctchange_09-14` , #PCH_RECFAC_09_14
  `rec_fit_facilities_perM_09` INT(8) NULL, #RECFACPTH09
  `rec_fit_facilities_perM_14` INT(8) NULL, #RECFACPTH14
  `rec_fit_facilities_perM_pctchange_09-14`,#PCH_RECFACPTH_09_14
  PRIMARY KEY (`county_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXIST `access`(
	`county_key` INT(8) NOT NULL, #FIPS
    `State` VARCHAR(255) NOT NULL,
    `County` VARCHAR(255) NOT NULL,
    `LACCESS_POP10` DECIMAL(10,7) NULL,
    `LACCESS_POP15` DECIMAL(10,7) NULL,
    `PCH_LACCESS_POP_10_15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_POP10` DECIMAL(10,7) NULL,
    `PCT_LACCESS_POP15` DECIMAL(10,7) NULL,
    `LACCESS_LOWI10` DECIMAL(10,7) NULL,
    `LACCESS_LOWI15` DECIMAL(10,7) NULL,
    `PCH_LACCESS_LOWI_10_15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_LOWI10` DECIMAL(10,7) NULL,
    `PCT_LACCESS_LOWI15` DECIMAL(10,7) NULL,
    `LACCESS_HHNV10` DECIMAL(10,7) NULL,
    `LACCESS_HHNV15` DECIMAL(10,7) NULL,
    `PCH_LACCESS_HHNV_10_15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_HHNV10` DECIMAL(10,7) NULL,
    `PCT_LACCESS_HHNV15` DECIMAL(10,7) NULL,
    `LACCESS_SNAP15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_SNAP15` DECIMAL(10,7) NULL,
    `LACCESS_CHILD10` DECIMAL(10,7) NULL,
    `LACCESS_CHILD15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_CHILD_10_15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_CHILD10` DECIMAL(10,7) NULL,
    `PCT_LACCESS_CHILD15` DECIMAL(10,7) NULL,
    `LACCESS_SENIORS10` DECIMAL(10,7) NULL,
    `LACCESS_SENIORS15` DECIMAL(10,7) NULL,
    `PCH_LACCESS_SENIORS_10_15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_SENIORS10` DECIMAL(10,7) NULL,
    `PCT_LACCESS_SENIORS15` DECIMAL(10,7) NULL,
    `LACCESS_WHITE15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_WHITE15`DECIMAL(10,7) NULL,
    `LACCESS_BLACK15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_BLACK15` DECIMAL(10,7) NULL,
    `LACCESS_HISP15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_HISP15` DECIMAL(10,7) NULL,
    `LACCESS_NHASIAN15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_NHASIAN15` DECIMAL(10,7) NULL,
    `LACCESS_NHNA15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_NHNA15` DECIMAL(10,7) NULL,
    `LACCESS_NHPI15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_NHPI15` DECIMAL(10,7) NULL,
    `LACCESS_MULTIR15` DECIMAL(10,7) NULL,
    `PCT_LACCESS_MULTIR15` DECIMAL(10,7) NULL,
    PRIMARY KEY (`county_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXIST `Local`(
	`county_key` INT(8) NOT NULL,
	`State` VARCHAR(50) NOT NULL,
	`County` VARCHAR(50) NOT NULL,
	`DIRSALES_FARMS07` INT(11) NULL,
	`DIRSALES_FARMS12` INT(11) NULL,
	`PCH_DIRSALES_FARMS_07_12` Decimal(7,3) NULL,
	`PCT_LOCLFARM07` Decimal(7,3) NULL,
	`PCT_LOCLFARM12` Decimal(7,3) NULL,
	`PCT_LOCLSALE07` Decimal(7,3) NULL,
	`PCT_LOCLSALE12` Decimal(7,3) NULL,
	`DIRSALES07` INT(11) NULL,
	`DIRSALES12` INT(11) NULL,
	`PCH_DIRSALES_07_12` Decimal(7,3) NULL,
	`PC_DIRSALES07` Decimal(7,3) NULL,
	`PC_DIRSALES12` Decimal(7,3) NULL,
	`PCH_PC_DIRSALES_07_12` Decimal(7,3) NULL,
	`FMRKT09` INT(11) NULL,
	`FMRKT16` INT(11) NULL,
	`PCH_FMRKT_09_16` Decimal(7,3) NULL,
	`FMRKTPTH09` Decimal(7,3) NULL,
	`FMRKTPTH16` Decimal(7,3) NULL,
	`PCH_FMRKTPTH_09_16` Decimal(7,3) NULL,
	`FMRKT_SNAP16` INT(11) NULL,
	`PCT_FMRKT_SNAP16` Decimal(7,3) NULL,
	`FMRKT_WIC16` INT(11) NULL,
	`PCT_FMRKT_WIC16` Decimal(7,3) NULL,
	`FMRKT_WICCASH16` INT(11) NULL,
	`PCT_FMRKT_WICCASH16` Decimal(7,3) NULL,
	`FMRKT_SFMNP16` INT(11) NULL,
	`PCT_FMRKT_SFMNP16` Decimal(7,3) NULL,
	`FMRKT_CREDIT16` INT(11) NULL,
	`PCT_FMRKT_CREDIT16` Decimal(7,3) NULL,
	`FMRKT_FRVEG16` INT(11) NULL,
	`PCT_FMRKT_FRVEG16` Decimal(7,3) NULL,
	`FMRKT_ANMLPROD16` INT(11) NULL,
	`PCT_FMRKT_ANMLPROD16` Decimal(7,3) NULL,
	`FMRKT_BAKED16` INT(11) NULL,
	`PCT_FMRKT_BAKED16` Decimal(7,3) NULL,
	`FMRKT_OTHERFOOD16` INT(11) NULL,
	`PCT_FMRKT_OTHERFOOD16` Decimal(7,3) NULL,
	`VEG_FARMS07` INT(11) NULL,
	`VEG_FARMS12` INT(11) NULL,
	`PCH_VEG_FARMS_07_12` Decimal(7,3) NULL,
	`VEG_ACRES07` INT(11) NULL,
	`VEG_ACRES12` INT(11) NULL,
	`PCH_VEG_ACRES_07_12` Decimal(7,3) NULL,
	`VEG_ACRESPTH07` Decimal(7,3) NULL,
	`VEG_ACRESPTH12` Decimal(7,3) NULL,
	`PCH_VEG_ACRESPTH_07_12` Decimal(7,3) NULL,
	`FRESHVEG_FARMS07` INT(11) NULL,
	`FRESHVEG_FARMS12` INT(11) NULL,
	`PCH_FRESHVEG_FARMS_07_12` Decimal(7,3) NULL,
	`FRESHVEG_ACRES07` INT(11) NULL,
	`FRESHVEG_ACRES12` INT(11) NULL,
	`PCH_FRESHVEG_ACRES_07_12` Decimal(7,3) NULL,
	`FRESHVEG_ACRESPTH07` Decimal(7,3) NULL,
	`FRESHVEG_ACRESPTH12` Decimal(7,3) NULL,
	`PCH_FRESHVEG_ACRESPTH_07_12` Decimal(7,3) NULL,
	`ORCHARD_FARMS07` INT(11) NULL,
	`ORCHARD_FARMS12` INT(11) NULL,
	`PCH_ORCHARD_FARMS_07_12` Decimal(7,3) NULL,
	`ORCHARD_ACRES07` INT(11) NULL,
	`ORCHARD_ACRES12` INT(11) NULL,
	`PCH_ORCHARD_ACRES_07_12` Decimal(7,3) NULL,
	`ORCHARD_ACRESPTH07` Decimal(7,3) NULL,
	`ORCHARD_ACRESPTH12` Decimal(7,3) NULL,
	`PCH_ORCHARD_ACRESPTH_07_12` Decimal(7,3) NULL,
	`BERRY_FARMS07` INT(11) NULL,
	`BERRY_FARMS12` INT(11) NULL,
	`PCH_BERRY_FARMS_07_12` Decimal(7,3) NULL,
	`BERRY_ACRES07` INT(11) NULL,
	`BERRY_ACRES12` INT(11) NULL,
	`PCH_BERRY_ACRES_07_12` Decimal(7,3) NULL,
	`BERRY_ACRESPTH07` Decimal(7,3) NULL,
	`BERRY_ACRESPTH12` Decimal(7,3) NULL,
	`PCH_BERRY_ACRESPTH_07_12` Decimal(7,3) NULL,
	`SLHOUSE07` INT(11) NULL,
	`SLHOUSE12` INT(11) NULL,
	`PCH_SLHOUSE_07_12` Decimal(7,3) NULL
	`GHVEG_FARMS07` INT(11) NULL,
	`GHVEG_FARMS12` INT(11) NULL,
	`PCH_GHVEG_FARMS_07_12` Decimal(7,3) NULL,
	`GHVEG_SQFT07` INT(11) NULL,
	`GHVEG_SQFT12` INT(11) NULL,
	`PCH_GHVEG_SQFT_07_12` Decimal(7,3) NULL,
	`GHVEG_SQFTPTH07` Decimal(7,3) NULL,
	`GHVEG_SQFTPTH12` Decimal(7,3) NULL,
	`PCH_GHVEG_SQFTPTH_07_12` Decimal(7,3) NULL,
	`FOODHUB16` INT(11) NULL,
	`CSA07` INT(11) NULL,
	`CSA12` INT(11) NULL,
	`PCH_CSA_07_12` Decimal(7,3) NULL,
	`AGRITRSM_OPS07` INT(11) NULL,
	`AGRITRSM_OPS12` INT(11) NULL,
	`PCH_AGRITRSM_OPS_07_12` Decimal(7,3) NULL,
	`AGRITRSM_RCT07` INT(11) NULL,
	`AGRITRSM_RCT12` INT(11) NULL,
	`PCH_AGRITRSM_RCT_07_12` Decimal(7,3) NULL,
	`FARM_TO_SCHOOL09` INT(11) NULL,
	`FARM_TO_SCHOOL13` INT(11) NULL,

    PRIMARY KEY (`county_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXIST `Socioeconomic`(
	`county_key` INT(8) NOT NULL,
	`State` VARCHAR(50) NOT NULL,
	`County` VARCHAR(50) NOT NULL,
	`PCT_NHWHITE10` Decimal(7,3) NULL,
	`PCT_NHBLACK10` Decimal(7,3) NULL,
	`PCT_HISP10` Decimal(7,3) NULL,
	`PCT_NHASIAN10` Decimal(7,3) NULL,
	`PCT_NHNA10` Decimal(7,3) NULL,
	`PCT_NHPI10` Decimal(7,3) NULL,
	`PCT_65OLDER10` Decimal(7,3) NULL,
	`PCT_18YOUNGER10` Decimal(7,3) NULL,
	`MEDHHINC15` INT(5) NULL,
	`POVRATE15` Decimal(7,3) NULL,
	`PERPOV10` INT(5) NULL,
	`CHILDPOVRATE15` Decimal(7,3) NULL,
	`PERCHLDPOV10` INT(5) NULL,
	`METRO13` INT(5) NULL,
	`POPLOSS10` INT(5) NULL,
    PRIMARY KEY (`county_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
