-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema jettsfireworks
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jettsfireworks` ;

-- -----------------------------------------------------
-- Schema jettsfireworks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jettsfireworks` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `jettsfireworks` ;

-- -----------------------------------------------------
-- Table `Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Customers` (
  `CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CustomerType` ENUM("individual", "Wholesale") NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `ContactInfo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `idCustomers_UNIQUE` (`CustomerID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Employees` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Employees` (
  `EmployeeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `EmploymentType` ENUM("Full Time", "Contracted") NOT NULL,
  `Role` VARCHAR(100) NOT NULL,
  `ContactInfo` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Orders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Orders` (
  `OrderId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Customers_CustomerID` INT UNSIGNED NOT NULL,
  `Employees_EmployeeID` INT UNSIGNED NOT NULL,
  `OrderDate` DATE NOT NULL,
  `TotalCost` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`OrderId`),
  UNIQUE INDEX `OrderId_UNIQUE` (`OrderId` ASC) VISIBLE,
  INDEX `fk_Orders_Customers_idx` (`Customers_CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Employees1_idx` (`Employees_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employees1`
    FOREIGN KEY (`Employees_EmployeeID`)
    REFERENCES `Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Fireworks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Fireworks` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Fireworks` (
  `FireworksID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(10,2) UNSIGNED NOT NULL,
  `Description` MEDIUMTEXT NOT NULL,
  `Classification` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`FireworksID`),
  UNIQUE INDEX `FireworksID_UNIQUE` (`FireworksID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OrderItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OrderItems` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OrderItems` (
  `OrderItemsId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Orders_OrderId` INT UNSIGNED NOT NULL,
  `Fireworks_FireworksID` INT UNSIGNED NOT NULL,
  `Quantity` INT UNSIGNED NOT NULL,
  `Price` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`OrderItemsId`),
  UNIQUE INDEX `OrderItemsId_UNIQUE` (`OrderItemsId` ASC) VISIBLE,
  INDEX `fk_OrderItems_Orders1_idx` (`Orders_OrderId` ASC) VISIBLE,
  INDEX `fk_OrderItems_Fireworks1_idx` (`Fireworks_FireworksID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderItems_Orders1`
    FOREIGN KEY (`Orders_OrderId`)
    REFERENCES `Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItems_Fireworks1`
    FOREIGN KEY (`Fireworks_FireworksID`)
    REFERENCES `Fireworks` (`FireworksID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Bunkers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bunkers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Bunkers` (
  `BunkerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ClassStored` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BunkerID`),
  UNIQUE INDEX `BunkerID_UNIQUE` (`BunkerID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Inventory` (
  `InventoryID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Fireworks_FireworksID` INT UNSIGNED NOT NULL,
  `Bunkers_BunkerID` INT UNSIGNED NOT NULL,
  `Quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`InventoryID`),
  UNIQUE INDEX `InventoryID_UNIQUE` (`InventoryID` ASC) VISIBLE,
  INDEX `fk_Inventory_Fireworks1_idx` (`Fireworks_FireworksID` ASC) VISIBLE,
  INDEX `fk_Inventory_Bunkers1_idx` (`Bunkers_BunkerID` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory_Fireworks1`
    FOREIGN KEY (`Fireworks_FireworksID`)
    REFERENCES `Fireworks` (`FireworksID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_Bunkers1`
    FOREIGN KEY (`Bunkers_BunkerID`)
    REFERENCES `Bunkers` (`BunkerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `PurchaseHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PurchaseHistory` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `PurchaseHistory` (
  `HistoryID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Orders_OrderId` INT UNSIGNED NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`HistoryID`),
  UNIQUE INDEX `HistoryID_UNIQUE` (`HistoryID` ASC) VISIBLE,
  INDEX `fk_PurchaseHistory_Orders1_idx` (`Orders_OrderId` ASC) VISIBLE,
  CONSTRAINT `fk_PurchaseHistory_Orders1`
    FOREIGN KEY (`Orders_OrderId`)
    REFERENCES `Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
