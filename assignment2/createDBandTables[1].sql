-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema universitydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema universitydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universitydb` DEFAULT CHARACTER SET utf8 ;
USE `universitydb` ;

-- -----------------------------------------------------
-- Table `universitydb`.`University`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`University` (
  `UID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Chancellor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitydb`.`Dean`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`Dean` (
  `DeanID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `DOB` DATETIME NOT NULL,
  PRIMARY KEY (`DeanID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitydb`.`College`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`College` (
  `CID` INT NOT NULL,
  `University` INT NOT NULL,
  `Dean` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (`CID`),
  INDEX `fk_UID_idx` (`University` ASC) VISIBLE,
  INDEX `fk_DeanID_idx` (`Dean` ASC) VISIBLE,
  CONSTRAINT `fk_UID`
    FOREIGN KEY (`University`)
    REFERENCES `universitydb`.`University` (`UID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DeanID`
    FOREIGN KEY (`Dean`)
    REFERENCES `universitydb`.`Dean` (`DeanID`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`Professor` (
  `PID` INT NOT NULL,
  `Department` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`PID`),
  INDEX `fk_DeptID_idx` (`Department` ASC) VISIBLE,
  CONSTRAINT `fk_DeptID`
    FOREIGN KEY (`Department`)
    REFERENCES `universitydb`.`Department` (`DeptID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`Department` (
  `DeptID` INT NOT NULL,
  `College` INT NOT NULL,
  `HOD` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeptID`),
  INDEX `fk_CID_idx` (`College` ASC) VISIBLE,
  INDEX `fk_PID_idx` (`HOD` ASC) VISIBLE,
  CONSTRAINT `fk_CID`
    FOREIGN KEY (`College`)
    REFERENCES `universitydb`.`College` (`CID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PID`
    FOREIGN KEY (`HOD`)
    REFERENCES `universitydb`.`Professor` (`PID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitydb`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`Course` (
  `CourseID` INT NOT NULL,
  `Department` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CourseID`),
  INDEX `fk_DeptID_idx` (`Department` ASC) VISIBLE,
  CONSTRAINT `fk_Dept_ID`
    FOREIGN KEY (`Department`)
    REFERENCES `universitydb`.`Department` (`DeptID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`Student` (
  `StudentID` INT NOT NULL,
  `Department` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `EnrolmentDate` DATETIME NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`StudentID`, `PhoneNumber`),
  INDEX `fk_DeptID_idx` (`Department` ASC) VISIBLE,
  CONSTRAINT `fk_DepartmentID`
    FOREIGN KEY (`Department`)
    REFERENCES `universitydb`.`Department` (`DeptID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `universitydb`.`Professor_has_Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitydb`.`Professor_has_Student` (
  `Professor_PID` INT NOT NULL,
  `Student_StudentID` INT NOT NULL,
  PRIMARY KEY (`Professor_PID`, `Student_StudentID`),
  INDEX `fk_Professor_has_Student_Student1_idx` (`Student_StudentID` ASC) VISIBLE,
  INDEX `fk_Professor_has_Student_Professor1_idx` (`Professor_PID` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_has_Student_Professor1`
    FOREIGN KEY (`Professor_PID`)
    REFERENCES `universitydb`.`Professor` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_has_Student_Student1`
    FOREIGN KEY (`Student_StudentID`)
    REFERENCES `universitydb`.`Student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
