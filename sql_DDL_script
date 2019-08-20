CREATE SCHEMA IF NOT EXISTS `nutrition` DEFAULT CHARACTER SET latin1 ;
USE `nutrition` ;

CREATE TABLE IF NOT EXISTS `Nutrition_Access` (
	`measure_key` INT(10) NOT NULL AUTO_INCREMENT,
	`variable_name` VARCHAR(255) NOT NULL,
    	`measure_value` FLOAT,
	`location_key` VARCHAR(10) NOT NULL,
	`year_key`INT(6) NOT NULL,
	`category_key` INT(6) NOT NULL,
	`program_attribute_key` INT(6) NOT NULL,
	`population_segment_key` INT(6) NOT NULL,
	`measure_name_key` INT(6) NOT NULL,
  PRIMARY KEY  (`measure_key`),
CONSTRAINT `fk_location_key`
    FOREIGN KEY (`location_key`)
    REFERENCES `nutrition`.`location` (`location_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_year_key`
    FOREIGN KEY (`year_key`)
    REFERENCES `nutrition`.`year` (`year_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_key`
    FOREIGN KEY (`category_key`)
    REFERENCES `nutrition`.`category` (`category_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,    
  CONSTRAINT `fk_subcategory_key`
    FOREIGN KEY (`program_attribute_key`)
    REFERENCES `nutrition`.`program_attribute` (`program_attribute_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_population_segment_key`
    FOREIGN KEY (`population_segment_key`)
    REFERENCES `nutrition`.`population_segment` (`population_segment_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_measure_name_key`
    FOREIGN KEY (`measure_name_key`)
    REFERENCES `nutrition`.`measure_name` (`measure_name_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;  
    
    
CREATE TABLE IF NOT EXISTS `Location` (
	`location_key`VARCHAR(10) NOT NULL, 
    	`county_key` VARCHAR(10) NOT NULL,
	`state_key` VARCHAR(10) NOT NULL,
    	`state_county_level_key` VARCHAR(10) NOT NULL,
  PRIMARY KEY  (`location_key`),
  CONSTRAINT `fk_county_key`
    FOREIGN KEY (`county_key`)
    REFERENCES `nutrition`.`county` (`county_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,    
  CONSTRAINT `fk_state_key`
    FOREIGN KEY (`state_key`)
    REFERENCES `nutrition`.`state` (`state_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
CONSTRAINT `fk_state_county_level_key`
    FOREIGN KEY (`state_county_level_key`)
    REFERENCES `nutrition`.`state_county` (`state_county_level_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `State` (
	`state_key` VARCHAR(5) NOT NULL,
   	`state_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY  (`state_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `County` (
	`county_key` VARCHAR(10) NOT NULL,
   	`county_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY  (`county_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `State_County` (
	`state_county_level_key` VARCHAR(5) NOT NULL,
    `level_name` VARCHAR(45) NOT NULL,
PRIMARY KEY  (`state_county_level_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Year` (
	`year_key` INT(6) NOT NULL,
    	`year` VARCHAR(15) NOT NULL,
PRIMARY KEY  (`year_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Category` (
	`category_key` INT(6) NOT NULL,
    	`category_name` VARCHAR(255) NOT NULL,
PRIMARY KEY  (`category_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Program_Attribute` (
	`program_attribute_key` INT(6) NOT NULL,
    	`program_attribute_name` VARCHAR(255) NOT NULL,
    	`program_attribute_description` VARCHAR(255),
PRIMARY KEY  (`program_attribute_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `Population_Segment` (
	`population_segment_key` INT(6) NOT NULL,
    	`population_segment_name` VARCHAR(255) NOT NULL,
PRIMARY KEY  (`population_segment_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Measure_Name` (
	`measure_name_key` INT(6) NOT NULL,
	`measure_name` VARCHAR(255),
PRIMARY KEY  (`measure_name_key`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
