-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `Workspace`;
DROP TABLE IF EXISTS `Employee`;
DROP TABLE IF EXISTS `Building`;
DROP TABLE IF EXISTS `Department`;
DROP TABLE IF EXISTS `OrderItem`;

CREATE TABLE `OrderItem` (
	`orderId` VARCHAR(191) NOT NULL,
	`itemId` VARCHAR(191) NOT NULL,
	`quantity` INT NOT NULL,
	`notes` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`orderId`,`itemId`)
);

CREATE TABLE `Department` (
	`deptNo` VARCHAR(191) NOT NULL,
	`deptName` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`deptNo`)
);

CREATE TABLE `Building` (
	`buildingCode` VARCHAR(191) NOT NULL,
	`city` VARCHAR(191) NOT NULL,
	`state` VARCHAR(191) NOT NULL,
	`country` VARCHAR(191) NOT NULL,
	`postalCode` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`buildingCode`)
);

CREATE TABLE `Employee` (
	`empNo` VARCHAR(191) NOT NULL,
	`firstName` VARCHAR(191) NOT NULL,
	`lastName` VARCHAR(191) NOT NULL,
	`birthDate` DATE NOT NULL,
	`gender` VARCHAR(191) NOT NULL,
	`hireDate` DATE NOT NULL,
	`departmentDeptNo` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_DEPARTMENT FOREIGN KEY(`departmentDeptNo`) REFERENCES `Department`(`deptNo`),
	`orderitemOrderId` VARCHAR(191) NOT NULL,
	`orderitemItemId` VARCHAR(191) NOT NULL,
	UNIQUE (`orderitemOrderId`, `orderitemItemId`),
	CONSTRAINT FK_ORDER_ITEM FOREIGN KEY(`orderitemOrderId`, `orderitemItemId`) REFERENCES `OrderItem`(`orderId`, `itemId`),
	PRIMARY KEY(`empNo`)
);

CREATE TABLE `Workspace` (
	`workspaceId` VARCHAR(191) NOT NULL,
	`workspaceType` VARCHAR(191) NOT NULL,
	`locationBuildingCode` VARCHAR(191) NOT NULL,
	CONSTRAINT FK_LOCATION FOREIGN KEY(`locationBuildingCode`) REFERENCES `Building`(`buildingCode`),
	`employeeEmpNo` VARCHAR(191) UNIQUE NOT NULL,
	CONSTRAINT FK_EMPLOYEE FOREIGN KEY(`employeeEmpNo`) REFERENCES `Employee`(`empNo`),
	PRIMARY KEY(`workspaceId`)
);
