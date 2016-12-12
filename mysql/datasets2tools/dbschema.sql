############################################################
############################################################
############### Datasets2Tools Schema Definition ###########
############################################################
############################################################

#######################################################
########## 1. Create Database #########################
#######################################################

##############################
##### 1.1 Create Database
##############################

### Create database
DROP DATABASE IF EXISTS `datasets2tools`;
CREATE DATABASE `datasets2tools`;

### Use database
USE `datasets2tools`;

### Disable foreign key checks
SET FOREIGN_KEY_CHECKS=0;

#######################################################
########## 2. Create Tables ###########################
#######################################################

##############################
##### 2.1 Database
##############################

DROP TABLE IF EXISTS `repository`;
CREATE TABLE `repository` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`repository_name` VARCHAR(20) NOT NULL,
	`repository_url` VARCHAR(500) NOT NULL,
    `repository_icon_url` VARCHAR(500),
    `repository_description` VARCHAR(500)
);

##############################
##### 2.2 Dataset
##############################

DROP TABLE IF EXISTS `dataset`;
CREATE TABLE `dataset` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`repository_fk` INT NOT NULL,
	`dataset_url` VARCHAR(100) UNIQUE NOT NULL,
	`dataset_accession` VARCHAR(20) NOT NULL,
	`dataset_title` TEXT NOT NULL,
    `taxon` VARCHAR(50) NOT NULL,
    `type` TEXT NOT NULL,
	`dataset_description` TEXT,

	# Foreign keys
	FOREIGN KEY (repository_fk)
		REFERENCES repository(id)
		ON DELETE RESTRICT
);

##############################
##### 2.3 Tool
##############################

DROP TABLE IF EXISTS `tool`;
CREATE TABLE `tool` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`tool_name` VARCHAR(20) NOT NULL,
	`tool_icon_url` VARCHAR(100) NOT NULL,
	`tool_url` VARCHAR(100) NOT NULL,
	`tool_description` TEXT
);

##############################
##### 2.4 Attribute
##############################

DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `tool_fk` INT NULL,
	`attribute_name` VARCHAR(20) NOT NULL,
	`attribute_description` TEXT,
    
    # Foreign keys
	FOREIGN KEY (tool_fk)
		REFERENCES tool(id)
		ON DELETE RESTRICT
);

##############################
##### 2.5 Attribute value
##############################

DROP TABLE IF EXISTS `attribute_value`;
CREATE TABLE `attribute_value` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `attribute_fk` INT NOT NULL,
	`value` VARCHAR(50) NOT NULL,
    
    # Foreign keys
	FOREIGN KEY (attribute_fk)
		REFERENCES attribute(id)
		ON DELETE RESTRICT
);

##############################
##### 2.6 Canned Analysis
##############################

DROP TABLE IF EXISTS `canned_analysis`;
CREATE TABLE `canned_analysis` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`dataset_fk` INT NOT NULL,
	`tool_fk` INT NOT NULL,
    `canned_analysis_url` VARCHAR(100) NOT NULL,

	# Foreign keys
	FOREIGN KEY (dataset_fk)
		REFERENCES dataset(id)
		ON DELETE RESTRICT,

	FOREIGN KEY (tool_fk)
		REFERENCES tool(id)
		ON DELETE RESTRICT
);

##############################
##### 2.7 cAnalysis data
##############################

DROP TABLE IF EXISTS `canned_analysis_metadata`;
CREATE TABLE `canned_analysis_metadata` (
	# Fields
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`canned_analysis_fk` INT NOT NULL,
	`attribute_fk` INT NOT NULL,
	`value` VARCHAR(20) NOT NULL,

	# Foreign keys
	FOREIGN KEY (canned_analysis_fk)
		REFERENCES canned_analysis(id)
		ON DELETE RESTRICT,

	FOREIGN KEY (attribute_fk)
		REFERENCES attribute(id)
		ON DELETE RESTRICT
);

#######################################################
########## 3. Other ###################################
#######################################################

### Reset foreign key checks
SET FOREIGN_KEY_CHECKS=1;