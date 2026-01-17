/**********************************************************************************************
 * Project        : HR Schema (Based on Oracle HR Sample Schema)
 * Script Name    : hr_tables.sql
 * Description    : Creation of core tables for HR schema in MySQL
 *
 * Database       : MySQL
 * Database Engine: InnoDB
 * Database Host  : Aiven - MySQL
 * Schema Name    : HR
 *
 * Author         : PaKo Araya
 * E-mail         : fraxxxxxxh@gmail.com
 * Company        : [Your Company or Personal Project]
 * Created Date   : 2026-01-16
 * Last Modified  : 2026-01-16
 *
 * Script Version : 1.0.1
 * Database Version Tested: MySQL 8.0.35
 * Charset        : utf8mb4
 * Collation      : utf8mb4_general_ci
 *
 * Dependencies   : None
 * Related Scripts: 
 * - 002_constraints.sql
 * - 003_indexes.sql
 *
 * Execution Tool : DBeaver / MySQL CLI
 * Environment    : [x]Development | [-]Test | [-]Production
 * Execution Mode : Manual
 * Backup Needed  : Yes
 * Rollback Plan  : Drop created tables
 * Estimated Time : < 1 minute
 * Risk Level     : Low
 *
 * Purpose        : Educational implementation of Oracle HR schema in MySQL
 * Compatibility  : ANSI SQL Standard + MySQL Extensions
 * Transactional  : Yes (InnoDB)
 * Idempotent     : Yes
 *
 * Notes:
 * - This script creates only table structures (DDL)
 * - Circular dependency between DEPARTMENTS and EMPLOYEES is resolved via ALTER TABLE
 * - Compatible with MySQL 8+
 *
 * Change Log:
 * --------------------------------------------------------------------------------------------
 * Version | Date       | Author      | Description
 * --------------------------------------------------------------------------------------------
 * 1.0.0   | 2026-01-16 | P. Araya    | Initial version - Tables creation
 * 1.0.1   | 2026-01-17 | P. Araya    | Fixed manager_id circularity and added check constraints
 *
 **********************************************************************************************/

DROP DATABASE IF EXISTS hr;

CREATE DATABASE IF NOT EXISTS hr
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE hr;

-- REGIONS TABLE
CREATE TABLE regions (
    region_id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    region_name     VARCHAR(50) NOT NULL 
);

-- COUNTRIES TABLE
CREATE TABLE countries(
    country_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_name    VARCHAR(50) NOT NULL,
    region_id       INT UNSIGNED NOT NULL,
    
    CONSTRAINT fk_countries_region 
        FOREIGN KEY (region_id)
            REFERENCES regions(region_id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE 
);

-- LOCATIONS TABLE
CREATE TABLE locations(
    location_id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    street_address  VARCHAR(50) NOT NULL,
    postal_code     VARCHAR(15) NOT NULL, 
    city            VARCHAR(50) NOT NULL,
    state_province  VARCHAR(30) NULL, 
    country_id      INT UNSIGNED NOT NULL, 
    
    CONSTRAINT fk_locations_countries 
        FOREIGN KEY (country_id)
            REFERENCES countries(country_id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE 
);

-- DEPARTMENTS TABLE
CREATE TABLE departments(
    department_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL, 
    manager_id      INT UNSIGNED NULL, -- NULL allowed initially to resolve circular dependency
    location_id     INT UNSIGNED NOT NULL,
    
    CONSTRAINT fk_departments_locations
        FOREIGN KEY (location_id)
            REFERENCES locations(location_id)
            ON DELETE RESTRICT 
            ON UPDATE CASCADE 
);

-- JOBS TABLE
CREATE TABLE jobs(
    job_id          VARCHAR(10) NOT NULL PRIMARY KEY,
    job_title       VARCHAR(50) NOT NULL,
    min_salary      DECIMAL(12,2) NOT NULL DEFAULT 0,
    max_salary      DECIMAL(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT chk_job_salary_range 
        CHECK (max_salary >= min_salary)
);

-- EMPLOYEES TABLE
CREATE TABLE employees(
    employee_id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL, 
    email           VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(20),
    hire_date       DATE NOT NULL,
    salary          DECIMAL(12,2) NOT NULL DEFAULT 0,
    commission_pct  DECIMAL(3,2) NOT NULL DEFAULT 0,
    -- NULL allowed for the top-level hierarchy (e.g., President/CEO)
    manager_id      INT UNSIGNED NULL, 
    job_id          VARCHAR(10) NOT NULL,
    department_id   INT UNSIGNED NOT NULL,
    
    -- 1. Relationship with Jobs table
    CONSTRAINT fk_employees_jobs 
        FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
            
    -- 2. Relationship with Departments table
    CONSTRAINT fk_employees_departments
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,

    -- 3. SELF-REFERENCE (Manager relationship)
    -- Establishes a 1:N relationship where an employee reports to another employee
    CONSTRAINT fk_employees_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,

    -- Integrity: No duplicate emails
    CONSTRAINT uq_employee_email 
        UNIQUE (email),

    -- Basic email format validation for production environment
    CONSTRAINT chk_employee_email_format
        CHECK (email LIKE '%_@__%.__%')
);

-- JOB_HISTORY TABLE
CREATE TABLE job_history(
    employee_id      INT UNSIGNED NOT NULL,
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL,
    job_id           VARCHAR(10) NOT NULL,
    department_id    INT UNSIGNED NOT NULL,

    -- Composite Primary Key: An employee can have multiple history records, 
    -- but only one starting at a specific date.
    PRIMARY KEY (employee_id, start_date),

    -- 1. Relationship with Employees table
    CONSTRAINT fk_job_history_employees
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,

    -- 2. Relationship with Jobs table
    CONSTRAINT fk_job_history_jobs
        FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    -- 3. Relationship with Departments table
    CONSTRAINT fk_job_history_departments
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    -- Business logic check: ensure end_date is after start_date
    CONSTRAINT chk_job_history_date_range 
        CHECK (end_date > start_date)
);

-- CIRCULAR REFERENCE RESOLUTION
-- Linking the department manager to the employees table after both exist
ALTER TABLE departments
    ADD CONSTRAINT fk_departments_manager
        FOREIGN KEY (manager_id) 
            REFERENCES employees(employee_id)
            ON DELETE SET NULL
            ON UPDATE CASCADE;



