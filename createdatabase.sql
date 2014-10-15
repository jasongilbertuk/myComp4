-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Date` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Date` (
  `dateID` INT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `publicHolidayID` INT NULL,
  PRIMARY KEY (`dateID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`publicHoliday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`publicHoliday` ;

CREATE TABLE IF NOT EXISTS `mydb`.`publicHoliday` (
  `publicHolidayID` INT NOT NULL AUTO_INCREMENT,
  `nameOfPublicHoliday` VARCHAR(40) NOT NULL,
  `dateID` INT NOT NULL,
  PRIMARY KEY (`publicHolidayID`),
  INDEX `fk_publicHoliday_Date_idx` (`dateID` ASC),
  CONSTRAINT `fk_publicHoliday_Date`
    FOREIGN KEY (`dateID`)
    REFERENCES `mydb`.`Date` (`dateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`absenceType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`absenceType` ;

CREATE TABLE IF NOT EXISTS `mydb`.`absenceType` (
  `absenceTypeID` INT NOT NULL AUTO_INCREMENT,
  `absenceTypeName` VARCHAR(20) NOT NULL,
  `usesAnnualLeave` TINYINT(1) NOT NULL,
  PRIMARY KEY (`absenceTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `employeeID` INT NOT NULL AUTO_INCREMENT,
  `employeeName` VARCHAR(50) NOT NULL,
  `emailAddress` VARCHAR(50) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `dateJoinedTheCompany` DATE NOT NULL,
  `annualLeaveEntitlement` INT(1) NOT NULL,
  `mainVacationRequestID` INT NULL,
  PRIMARY KEY (`employeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`approvedAbsenceBooking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`approvedAbsenceBooking` ;

CREATE TABLE IF NOT EXISTS `mydb`.`approvedAbsenceBooking` (
  `approvedAbsenceBookingID` INT NOT NULL AUTO_INCREMENT,
  `employeeID` INT NOT NULL,
  `absenceStartDate` DATE NOT NULL,
  `approvedEndDate` DATE NOT NULL,
  `absenceTypeID` INT NOT NULL,
  PRIMARY KEY (`approvedAbsenceBookingID`),
  INDEX `fk_approvedAbsenceBooking_absenceType1_idx` (`absenceTypeID` ASC),
  INDEX `fk_approvedAbsenceBooking_Employee1_idx` (`employeeID` ASC),
  CONSTRAINT `fk_approvedAbsenceBooking_absenceType1`
    FOREIGN KEY (`absenceTypeID`)
    REFERENCES `mydb`.`absenceType` (`absenceTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_approvedAbsenceBooking_Employee1`
    FOREIGN KEY (`employeeID`)
    REFERENCES `mydb`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`approvedAbsenceBookingDate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`approvedAbsenceBookingDate` ;

CREATE TABLE IF NOT EXISTS `mydb`.`approvedAbsenceBookingDate` (
  `approvedAbsenceBookingDateID` INT NOT NULL AUTO_INCREMENT,
  `dateID` INT NOT NULL,
  `approvedAbsenceBookingID` INT NOT NULL,
  PRIMARY KEY (`approvedAbsenceBookingDateID`),
  INDEX `fk_approvedAbsenceBookingDate_Date1_idx` (`dateID` ASC),
  INDEX `fk_approvedAbsenceBookingDate_approvedAbsenceBooking1_idx` (`approvedAbsenceBookingID` ASC),
  CONSTRAINT `fk_approvedAbsenceBookingDate_Date1`
    FOREIGN KEY (`dateID`)
    REFERENCES `mydb`.`Date` (`dateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_approvedAbsenceBookingDate_approvedAbsenceBooking1`
    FOREIGN KEY (`approvedAbsenceBookingID`)
    REFERENCES `mydb`.`approvedAbsenceBooking` (`approvedAbsenceBookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`adHocAbsenceRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`adHocAbsenceRequest` ;

CREATE TABLE IF NOT EXISTS `mydb`.`adHocAbsenceRequest` (
  `adHocAbsenceRequestID` INT NOT NULL AUTO_INCREMENT,
  `employeeID` INT NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `absenceTypeID` INT NOT NULL,
  PRIMARY KEY (`adHocAbsenceRequestID`),
  INDEX `fk_adHocAbsenceRequest_absenceType1_idx` (`absenceTypeID` ASC),
  INDEX `fk_adHocAbsenceRequest_Employee1_idx` (`employeeID` ASC),
  CONSTRAINT `fk_adHocAbsenceRequest_absenceType1`
    FOREIGN KEY (`absenceTypeID`)
    REFERENCES `mydb`.`absenceType` (`absenceTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adHocAbsenceRequest_Employee1`
    FOREIGN KEY (`employeeID`)
    REFERENCES `mydb`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`companyRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`companyRole` ;

CREATE TABLE IF NOT EXISTS `mydb`.`companyRole` (
  `companyRoleID` INT NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(30) NOT NULL,
  `minimumStaffingLevel` INT(1) NOT NULL,
  PRIMARY KEY (`companyRoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employeeRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`employeeRole` ;

CREATE TABLE IF NOT EXISTS `mydb`.`employeeRole` (
  `employeeRoleID` INT NOT NULL AUTO_INCREMENT,
  `employeeID` INT NOT NULL,
  `companyRoleID` INT NOT NULL,
  PRIMARY KEY (`employeeRoleID`),
  INDEX `fk_employeeRole_Employee1_idx` (`employeeID` ASC),
  INDEX `fk_employeeRole_companyRole1_idx` (`companyRoleID` ASC),
  CONSTRAINT `fk_employeeRole_Employee1`
    FOREIGN KEY (`employeeID`)
    REFERENCES `mydb`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employeeRole_companyRole1`
    FOREIGN KEY (`companyRoleID`)
    REFERENCES `mydb`.`companyRole` (`companyRoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mainVacationRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`mainVacationRequest` ;

CREATE TABLE IF NOT EXISTS `mydb`.`mainVacationRequest` (
  `mainVacationRequestID` INT NOT NULL AUTO_INCREMENT,
  `employeeID` INT NOT NULL,
  `firstChoiceStartDate` DATE NOT NULL,
  `firstChoiceEndDate` DATE NOT NULL,
  `secondChoiceStartDate` DATE NOT NULL,
  `secondChoiceEndDate` DATE NOT NULL,
  PRIMARY KEY (`mainVacationRequestID`),
  INDEX `fk_mainVacationRequest_Employee1_idx` (`employeeID` ASC),
  CONSTRAINT `fk_mainVacationRequest_Employee1`
    FOREIGN KEY (`employeeID`)
    REFERENCES `mydb`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
