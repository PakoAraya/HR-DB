
/**********************************************************************************************
 * Project        : HR Schema (Based on Oracle HR Sample Schema)
 * Script Name    : hr_data_seed.sql
 * Description    : Population of sample data for HR schema (DML)
 *
 * Database       : MySQL
 * Database Engine: InnoDB
 * Database Host  : Aiven - MySQL
 * Schema Name    : HR
 *
 * Author         : PaKo Araya
 * E-mail         : fraxxxxxxh@gmail.com
 * Company        : [Your Company or Personal Project]
 * Created Date   : 2026-01-17
 * Last Modified  : 2026-01-17
 *
 * Script Version : 1.0.0
 * Database Version Tested: MySQL 8.0.35
 * Charset        : utf8mb4
 * Collation      : utf8mb4_general_ci
 *
 * Dependencies   : 
 * - hr_tables.sql (Must be executed first)
 *
 * Execution Tool : DBeaver / MySQL CLI
 * Environment    : [x]Development | [-]Test | [-]Production
 * Execution Mode : Manual
 * Backup Needed  : Yes
 * Rollback Plan  : TRUNCATE all tables or DELETE FROM [table]
 * Estimated Time : < 1 minute
 * Risk Level     : Medium (Data manipulation)
 *
 * Purpose        : Populate the HR schema with educational and testing data
 * Compatibility  : ANSI SQL Standard + MySQL Extensions
 * Transactional  : Yes (Wrapped in START TRANSACTION)
 * Idempotent     : Yes (Uses TRUNCATE or DELETE to ensure clean state)
 *
 * Notes:
 * - This script performs Data Manipulation (DML)
 * - Inserts records in the correct order to respect Foreign Key constraints
 * - Includes samples for all 7 core tables
 * - Inserts follow referential integrity order
 * - Foreign keys must already exist
 * - Safe for re-execution using DELETE/TRUNCATE strategy
 * - Designed for development and testing environments
 * 
 * WARNING:
 *  - This script is NOT intended for execution in production environments.
 *  - Uses TRUNCATE which will destroy existing data.
 *
 * Change Log:
 * --------------------------------------------------------------------------------------------
 * Version | Date       | Author      | Description
 * --------------------------------------------------------------------------------------------
 * 1.0.0   | 2026-01-17 | P. Araya    | Initial version - Data population (Seeds)
 *
 **********************************************************************************************/

-- =====================================================================
-- SAFETY CHECK: Ensure correct database
-- =====================================================================

USE hr;

SELECT DATABASE() INTO @current_db;

SELECT IF(@current_db NOT IN ('hr', 'hr_dev', 'hr_test'),
    CONCAT('WARNING: You are connected to "', @current_db, '". Expected: hr'),
    'OK - Correct database selected') AS environment_check;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE job_history;
TRUNCATE TABLE employees;
TRUNCATE TABLE departments;
TRUNCATE TABLE jobs;
TRUNCATE TABLE locations;
TRUNCATE TABLE countries;
TRUNCATE TABLE regions;

SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

-- 1. Insert Regions
INSERT INTO regions (region_id, region_name) VALUES
(1, 'Europe'),
(2, 'Americas'),
(3, 'Asia'),
(4, 'Middle East and Africa');

-- 2. Insert Countries
INSERT INTO countries (country_id, country_name, region_id) VALUES
(1, 'Italy', 1), (2, 'Japan', 3), (3, 'United States of America', 2),
(4, 'Canada', 2), (5, 'China', 3), (6, 'India', 3), (7, 'Australia', 3),
(8, 'Zimbabwe', 4), (9, 'United Kingdom', 1), (10, 'France', 1),
(11, 'Germany', 1), (12, 'Zambia', 4), (13, 'Egypt', 4), (14, 'Brazil', 2),
(15, 'Switzerland', 1), (16, 'Netherlands', 1), (17, 'Mexico', 2),
(18, 'Singapore', 3), (19, 'Belgium', 1), (20, 'Denmark', 1),
(21, 'Argentina', 2), (22, 'Spain', 1), (23, 'Nigeria', 4),
(24, 'South Africa', 4), (25, 'Ireland', 1);

-- 3. Insert Locations (Corrected for NOT NULL postal_code)
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
(1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 1),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 1),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 2),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 2),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 3),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 3),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 3),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 3),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 4),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 4),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 5),
(2100, '1298 Vileparle', '490231', 'Bombay', 'Maharashtra', 6),
(2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 7),
(2300, '198 Clementi North', '540198', 'Singapore', NULL, 18),
(2400, '8204 Arthur St', 'W1U 6AG', 'London', NULL, 9), 
(2500, 'Magdalen Centre', 'OX9 9ZB', 'Oxford', 'Oxford', 9);

-- 4. Insert Departments
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
(10, 'Administration', NULL, 1700),
(20, 'Marketing', NULL, 1800),
(30, 'Purchasing', NULL, 1700),
(40, 'Human Resources', NULL, 2400),
(50, 'Shipping', NULL, 1500),
(60, 'IT', NULL, 1400),
(70, 'Public Relations', NULL, 2500), -- Corregido de 2700 a 2500
(80, 'Sales', NULL, 2500),
(90, 'Executive', NULL, 1700),
(100, 'Finance', NULL, 1700),
(110, 'Accounting', NULL, 1700);

-- 5. Insert Jobs
INSERT INTO jobs VALUES
('AD_PRES','President',20000,40000),
('AD_VP','Administration Vice President',15000,30000),
('AD_ASST','Administration Assistant',3000,6000),
('FI_MGR','Finance Manager',8200,16000),
('FI_ACCOUNT','Accountant',4200,9000),
('AC_MGR','Accounting Manager',8200,16000),
('AC_ACCOUNT','Public Accountant',4200,9000),
('SA_MAN','Sales Manager',10000,20000),
('SA_REP','Sales Representative',6000,12000),
('PU_MAN','Purchasing Manager',8000,15000),
('PU_CLERK','Purchasing Clerk',2500,5500),
('ST_MAN','Stock Manager',5500,8500),
('ST_CLERK','Stock Clerk',2000,5000),
('SH_CLERK','Shipping Clerk',2500,5500),
('IT_PROG','Programmer',4000,10000),
('MK_MAN','Marketing Manager',9000,15000),
('MK_REP','Marketing Representative',4000,9000),
('HR_REP','Human Resources Representative',4000,9000),
('PR_REP','Public Relations Representative',4500,10500);

-- 6. Insert Employees
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'sking@company.com', '515.123.4567', '2013-06-17', 'AD_PRES', 24000, NULL, 90),
(101, 'Neena', 'Kochhar', 'nkochhar@company.com', '515.123.4568', '2015-09-21', 'AD_VP', 17000, 100, 90),
(102, 'Lex', 'De Haan', 'ldehaan@company.com', '515.123.4569', '2011-01-13', 'AD_VP', 17000, 100, 90),
(103, 'Alexander', 'Hunold', 'ahunold@company.com', '590.423.4567', '2016-01-03', 'IT_PROG', 9000, 102, 60),
(108, 'Nancy', 'Greenberg', 'ngreenbe@company.com', '515.124.4569', '2012-08-17', 'FI_MGR', 12000, 101, 100),
(114, 'Den', 'Raphaely', 'draphael@company.com', '515.127.4561', '2012-12-07', 'PU_MAN', 11000, 100, 30),
(120, 'Matthew', 'Weiss', 'mweiss@company.com', '650.123.1234', '2014-07-18', 'ST_MAN', 8000, 100, 50),
(121, 'Adam', 'Fripp', 'afripp@company.com', '650.123.2234', '2015-04-10', 'ST_MAN', 8200, 100, 50),
(145, 'John', 'Russell', 'jrussell@company.com', '011.44.1344.429268', '2014-10-01', 'SA_MAN', 14000, 100, 80),
(146, 'Karen', 'Partners', 'kpartner@company.com', '011.44.1344.467268', '2015-01-05', 'SA_MAN', 13500, 100, 80),
(201, 'Michael', 'Hartstein', 'mhartste@company.com', '515.123.5555', '2014-02-17', 'MK_MAN', 13000, 100, 20),
(205, 'Shelley', 'Higgins', 'shiggins@company.com', '515.123.8080', '2012-06-07', 'AC_MGR', 12000, 101, 110),
(104, 'Bruce', 'Ernst', 'bernst@company.com', '590.423.4568', '2017-05-21', 'IT_PROG', 6000, 103, 60),
(105, 'David', 'Austin', 'daustin@company.com', '590.423.4569', '2015-06-25', 'IT_PROG', 4800, 103, 60),
(106, 'Valli', 'Pagaballa', 'vpatabal@company.com', '590.423.4560', '2016-02-05', 'IT_PROG', 4800, 103, 60),
(107, 'Diana', 'Lorentz', 'dlorentz@company.com', '590.423.5567', '2017-02-07', 'IT_PROG', 4200, 103, 60),
(109, 'Daniel', 'Faviet', 'dfaviet@company.com', '515.124.4169', '2012-08-16', 'FI_ACCOUNT', 9000, 108, 100),
(110, 'John', 'Chen', 'jchen@company.com', '515.124.4269', '2015-09-28', 'FI_ACCOUNT', 8200, 108, 100),
(111, 'Ismael', 'Sciarra', 'isciarra@company.com', '515.124.4369', '2015-09-30', 'FI_ACCOUNT', 7700, 108, 100),
(112, 'Jose Manuel', 'Urman', 'jmurman@company.com', '515.124.4469', '2016-03-07', 'FI_ACCOUNT', 7800, 108, 100),
(113, 'Luis', 'Popp', 'lpopp@company.com', '515.124.4567', '2017-12-07', 'FI_ACCOUNT', 6900, 108, 100),
(206, 'William', 'Gietz', 'wgietz@company.com', '515.123.8181', '2012-06-07', 'AC_ACCOUNT', 8300, 205, 110),
(115, 'Alexander', 'Khoo', 'akhoo@company.com', '515.127.4562', '2013-05-18', 'PU_CLERK', 3100, 114, 30),
(116, 'Shelli', 'Baida', 'sbaida@company.com', '515.127.4563', '2015-12-24', 'PU_CLERK', 2900, 114, 30),
(117, 'Sigal', 'Tobias', 'stobias@company.com', '515.127.4564', '2015-07-24', 'PU_CLERK', 2800, 114, 30),
(118, 'Guy', 'Himuro', 'ghimuro@company.com', '515.127.4565', '2016-11-15', 'PU_CLERK', 2600, 114, 30),
(119, 'Karen', 'Colmenares', 'kcolmena@company.com', '515.127.4566', '2017-08-10', 'PU_CLERK', 2500, 114, 30),
(122, 'Kauko', 'Palo', 'kpalo@company.com', '650.123.3234', '2016-07-18', 'ST_CLERK', 3200, 120, 50),
(123, 'Shanta', 'Vollman', 'svollman@company.com', '650.123.4234', '2015-10-10', 'ST_CLERK', 6500, 120, 50),
(124, 'Kevin', 'Mourgos', 'kmourgos@company.com', '650.123.5234', '2017-11-16', 'ST_CLERK', 5800, 120, 50),
(125, 'Julia', 'Nayer', 'jnayer@company.com', '650.124.1214', '2015-07-16', 'ST_CLERK', 3200, 120, 50),
(126, 'Irene', 'Mikkilineni', 'imikkili@company.com', '650.124.1224', '2016-09-28', 'ST_CLERK', 2700, 120, 50),
(127, 'James', 'Landry', 'jlandry@company.com', '650.124.1334', '2017-01-14', 'ST_CLERK', 2400, 120, 50),
(128, 'Steven', 'Markle', 'smarkle@company.com', '650.124.1434', '2018-03-08', 'ST_CLERK', 2200, 120, 50),
(150, 'Peter', 'Tucker', 'ptucker@company.com', '011.44.1344.129268', '2015-01-30', 'SA_REP', 10000, 145, 80),
(151, 'David', 'Bernstein', 'dbernste@company.com', '011.44.1344.345268', '2015-03-24', 'SA_REP', 9500, 145, 80),
(152, 'Peter', 'Hall', 'phall@company.com', '011.44.1344.478968', '2015-08-20', 'SA_REP', 9000, 145, 80),
(153, 'Christopher', 'Olsen', 'colsen@company.com', '011.44.1344.498718', '2016-03-30', 'SA_REP', 8000, 145, 80),
(154, 'Nanette', 'Cambrault', 'ncambrau@company.com', '011.44.1344.987668', '2016-12-09', 'SA_REP', 7500, 145, 80),
(155, 'Oliver', 'Tuvault', 'otuvault@company.com', '011.44.1344.486508', '2017-11-23', 'SA_REP', 7000, 145, 80),
(156, 'Janette', 'King', 'jking@company.com', '011.44.1345.429268', '2018-01-30', 'SA_REP', 10000, 146, 80),
(157, 'Patrick', 'Sully', 'psully@company.com', '011.44.1345.929268', '2018-03-04', 'SA_REP', 9500, 146, 80),
(158, 'Allan', 'McEwen', 'amcewen@company.com', '011.44.1345.829268', '2018-08-01', 'SA_REP', 9000, 146, 80),
(159, 'Lindsey', 'Smith', 'lsmith@company.com', '011.44.1345.729268', '2018-03-10', 'SA_REP', 8000, 146, 80),
(160, 'Louise', 'Doran', 'ldoran@company.com', '011.44.1345.629268', '2018-12-15', 'SA_REP', 7500, 146, 80),
(161, 'Sarath', 'Sewall', 'ssewall@company.com', '011.44.1345.529268', '2018-11-03', 'SA_REP', 7000, 146, 80),
(162, 'Clara', 'Vishney', 'cvishney@company.com', '011.44.1346.129268', '2019-11-11', 'SA_REP', 10500, 146, 80),
(163, 'Danielle', 'Greene', 'dgreene@company.com', '011.44.1346.229268', '2019-03-19', 'SA_REP', 9500, 146, 80), -- Corregido: 'Greene'
(164, 'Mattea', 'Marvins', 'mmarvins@company.com', '011.44.1346.329268', '2020-01-24', 'SA_REP', 7200, 146, 80),
(165, 'David', 'Lee', 'dlee@company.com', '011.44.1346.529268', '2020-02-23', 'SA_REP', 6800, 146, 80),
(166, 'Sundar', 'Ande', 'sande@company.com', '011.44.1346.629268', '2020-03-24', 'SA_REP', 6400, 146, 80),
(167, 'Amit', 'Banda', 'abanda@company.com', '011.44.1346.729268', '2020-04-21', 'SA_REP', 6200, 146, 80),
(168, 'Lisa', 'Ozer', 'lozer@company.com', '011.44.1343.929268', '2020-05-11', 'SA_REP', 11500, 145, 80),
(169, 'Harrison', 'Bloom', 'hbloom@company.com', '011.44.1343.829268', '2020-03-23', 'SA_REP', 10000, 145, 80),
(170, 'Tayler', 'Fox', 'tfox@company.com', '011.44.1343.729268', '2020-01-24', 'SA_REP', 9600, 145, 80),
(171, 'William', 'Smith', 'wsmith2@company.com', '011.44.1343.629268', '2020-02-23', 'SA_REP', 7400, 145, 80),
(172, 'Elizabeth', 'Bates', 'ebates@company.com', '011.44.1343.529268', '2020-03-24', 'SA_REP', 7300, 145, 80),
(173, 'Sundita', 'Kumar', 'skumar@company.com', '011.44.1343.329268', '2020-04-21', 'SA_REP', 6100, 145, 80),
(174, 'Ellen', 'Abel', 'eabel@company.com', '011.44.1644.429267', '2021-05-11', 'SA_REP', 11000, 146, 80),
(175, 'Alyssa', 'Hutton', 'ahutton@company.com', '011.44.1644.429266', '2021-03-19', 'SA_REP', 8800, 146, 80),
(176, 'Jonathon', 'Taylor', 'jtaylor@company.com', '011.44.1644.429265', '2021-01-24', 'SA_REP', 8600, 146, 80),
(177, 'Jack', 'Livingston', 'jliving@company.com', '011.44.1644.429264', '2021-02-23', 'SA_REP', 8400, 146, 80),
(178, 'Kimberely', 'Grant', 'kgrant@company.com', '011.44.1644.429263', '2021-05-24', 'SA_REP', 7000, 146, 80),
(179, 'Charles', 'Johnson', 'cjohnson@company.com', '011.44.1644.429262', '2021-01-04', 'SA_REP', 6200, 146, 80),
(180, 'Winston', 'Taylor', 'wtaylor@company.com', '650.507.9876', '2021-01-24', 'SH_CLERK', 3200, 120, 50),
(181, 'Jean', 'Fleaur', 'jfleaur@company.com', '650.507.9877', '2021-02-23', 'SH_CLERK', 3100, 120, 50),
(182, 'Martha', 'Sullivan', 'msulliva@company.com', '650.507.9878', '2021-06-21', 'SH_CLERK', 2500, 120, 50),
(183, 'Girard', 'Geoni', 'ggeoni@company.com', '650.507.9879', '2021-02-03', 'SH_CLERK', 2800, 120, 50),
(184, 'Nandita', 'Sarchand', 'nsarchan@company.com', '650.509.1876', '2021-01-27', 'SH_CLERK', 4200, 121, 50),
(185, 'Alexis', 'Bull', 'abull@company.com', '650.509.2876', '2021-02-20', 'SH_CLERK', 4100, 121, 50),
(186, 'Julia', 'Dellinger', 'jdelling@company.com', '650.509.3876', '2021-06-24', 'SH_CLERK', 3400, 121, 50),
(187, 'Anthony', 'Cabrio', 'acabrio@company.com', '650.509.4876', '2021-02-07', 'SH_CLERK', 3000, 121, 50),
(188, 'Kelly', 'Chung', 'kchung@company.com', '650.505.1876', '2022-06-14', 'SH_CLERK', 3800, 122, 50),
(189, 'Jennifer', 'Dilly', 'jdilly@company.com', '650.505.2876', '2022-08-13', 'SH_CLERK', 3600, 122, 50),
(190, 'Timothy', 'Gates', 'tgates@company.com', '650.505.3876', '2022-07-11', 'SH_CLERK', 2900, 122, 50),
(191, 'Randall', 'Perkins', 'rperkins@company.com', '650.505.4876', '2022-12-19', 'SH_CLERK', 2500, 122, 50),
(192, 'Sarah', 'Bell', 'sbell@company.com', '650.501.1876', '2022-02-04', 'SH_CLERK', 4000, 123, 50),
(193, 'Britney', 'Everett', 'beverett@company.com', '650.501.2876', '2022-03-03', 'SH_CLERK', 3900, 123, 50),
(194, 'Samuel', 'McCain', 'smccain@company.com', '650.501.3876', '2022-07-01', 'SH_CLERK', 3200, 123, 50),
(195, 'Vance', 'Jones', 'vjones@company.com', '650.501.4876', '2022-03-17', 'SH_CLERK', 2800, 123, 50),
(196, 'Alana', 'Walsh', 'awalsh@company.com', '650.507.9811', '2023-04-24', 'SH_CLERK', 3100, 124, 50),
(197, 'Kevin', 'Feeney', 'kfeeney@company.com', '650.507.9822', '2023-05-23', 'SH_CLERK', 3000, 124, 50),
(198, 'Donald', 'OConnell', 'doconnel@company.com', '650.507.9833', '2023-06-21', 'SH_CLERK', 2600, 124, 50),
(199, 'Douglas', 'Grant', 'dgrant@company.com', '650.507.9844', '2023-01-13', 'SH_CLERK', 2600, 124, 50),
(200, 'Jennifer', 'Whalen', 'jwhalen@company.com', '515.123.4444', '2013-09-17', 'AD_ASST', 4400, 101, 10),
(202, 'Pat', 'Fay', 'pfay@company.com', '603.123.6666', '2015-08-17', 'MK_REP', 6000, 201, 20),
(203, 'Susan', 'Mavris', 'smavris@company.com', '515.123.7777', '2012-06-07', 'HR_REP', 6500, 101, 40),
(204, 'Hermann', 'Baer', 'hbaer@company.com', '515.123.8888', '2012-06-07', 'PR_REP', 10000, 101, 70),
(207, 'PaKo', 'Araya', 'paraya@company.com', '555.010.2026', '2026-01-16', 'IT_PROG', 9500, 103, 60),
(208, 'Marta', 'Silva', 'msilva@company.com', '555.101', '2020-01-01', 'SH_CLERK', 3000, 121, 50),
(209, 'Juan', 'Perez', 'jperez@company.com', '555.102', '2020-01-02', 'SH_CLERK', 3100, 121, 50),
(210, 'Erik', 'Larsen', 'elarsen@company.com', '555.103', '2020-01-03', 'ST_CLERK', 2500, 121, 50),
(211, 'Ana', 'Schmidt', 'aschmidt@company.com', '555.104', '2020-01-04', 'ST_CLERK', 2600, 121, 50),
(212, 'Li', 'Wei', 'lwei@company.com', '555.105', '2020-01-05', 'IT_PROG', 7000, 103, 60),
(213, 'Raj', 'Patel', 'rpatel@company.com', '555.106', '2020-01-06', 'IT_PROG', 7100, 103, 60),
(214, 'Elena', 'Petrova', 'epetrova@company.com', '555.107', '2020-01-07', 'SA_REP', 8000, 146, 80),
(215, 'Yuki', 'Tanaka', 'ytanaka@company.com', '555.108', '2020-01-08', 'SA_REP', 8100, 146, 80),
(216, 'Marc', 'Dubois', 'mdubois@company.com', '555.109', '2020-01-09', 'FI_ACCOUNT', 6500, 108, 100),
(217, 'Sophie', 'Muller', 'smuller@company.com', '555.110', '2020-01-10', 'AC_ACCOUNT', 6600, 205, 110),
(218, 'Carlos', 'Ruiz', 'cruiz@company.com', '555.0218', '2021-01-15', 'IT_PROG', 7200, 103, 60),
(219, 'Beatriz', 'Luna', 'bluna@company.com', '555.0219', '2021-02-10', 'IT_PROG', 7300, 103, 60),
(220, 'Felipe', 'Torres', 'ftorres@company.com', '555.0220', '2021-03-05', 'IT_PROG', 6900, 103, 60),
(221, 'Ingrid', 'Berg', 'iberg@company.com', '555.0221', '2021-04-12', 'IT_PROG', 7500, 103, 60),
(222, 'Kevin', 'Mitnick', 'kmitnick@company.com', '555.0222', '2021-05-20', 'IT_PROG', 8000, 103, 60),
(223, 'Ada', 'Lovelace', 'alovelace@company.com', '555.0223', '2021-06-15', 'IT_PROG', 9500, 103, 60),
(224, 'Linus', 'Torvalds', 'ltorvalds@company.com', '555.0224', '2021-07-01', 'IT_PROG', 9200, 103, 60),
(225, 'Grace', 'Hopper', 'ghopper@company.com', '555.0225', '2021-08-22', 'IT_PROG', 8800, 103, 60),
(226, 'Samuel', 'Jackson', 'sjackson@company.com', '650.555.0101', '2022-01-10', 'ST_CLERK', 2800, 121, 50),
(227, 'Robert', 'De Niro', 'rdeniro@company.com', '650.555.0102', '2022-01-15', 'ST_CLERK', 2900, 121, 50),
(228, 'Al', 'Pacino', 'apacino@company.com', '650.555.0103', '2022-02-01', 'ST_CLERK', 3000, 121, 50),
(229, 'Morgan', 'Freeman', 'mfreeman@company.com', '650.555.0104', '2022-02-10', 'SH_CLERK', 3200, 120, 50),
(230, 'Denzel', 'Washington', 'dwashing@company.com', '650.555.0105', '2022-03-05', 'SH_CLERK', 3100, 120, 50),
(231, 'Brad', 'Pitt', 'bpitt@company.com', '650.555.0106', '2022-03-20', 'SH_CLERK', 3300, 120, 50),
(232, 'Angelina', 'Jolie', 'ajolie@company.com', '650.555.0107', '2022-04-12', 'ST_CLERK', 2700, 121, 50),
(233, 'Leonardo', 'DiCaprio', 'ldicaprio@company.com', '650.555.0108', '2022-05-01', 'ST_CLERK', 2600, 121, 50),
(234, 'Kate', 'Winslet', 'kwinslet@company.com', '650.555.0109', '2022-05-15', 'ST_CLERK', 2500, 121, 50),
(235, 'Tom', 'Hanks', 'thanks@company.com', '650.555.0110', '2022-06-01', 'SH_CLERK', 3500, 120, 50),
(236, 'Meryl', 'Streep', 'mstreep@company.com', '650.555.0111', '2022-06-20', 'SH_CLERK', 3400, 120, 50),
(237, 'Anthony', 'Hopkins', 'ahopkins@company.com', '650.555.0112', '2022-07-05', 'ST_CLERK', 3100, 121, 50),
(238, 'Gary', 'Oldman', 'goldman@company.com', '650.555.0113', '2022-07-25', 'ST_CLERK', 3000, 121, 50),
(239, 'Christian', 'Bale', 'cbale@company.com', '650.555.0114', '2022-08-10', 'ST_CLERK', 2900, 121, 50),
(240, 'Heath', 'Ledger', 'hledger@company.com', '650.555.0115', '2022-09-01', 'SH_CLERK', 3000, 120, 50),
(241, 'Joaquin', 'Phoenix', 'jphoenix@company.com', '650.555.0116', '2022-09-15', 'SH_CLERK', 3100, 120, 50),
(242, 'Russell', 'Crowe', 'rcrowe@company.com', '650.555.0117', '2022-10-01', 'ST_CLERK', 3200, 121, 50),
(243, 'Nicole', 'Kidman', 'nkidman@company.com', '650.555.0118', '2022-10-20', 'ST_CLERK', 2800, 121, 50),
(244, 'Cate', 'Blanchett', 'cblanche@company.com', '650.555.0119', '2022-11-05', 'ST_CLERK', 2700, 121, 50),
(245, 'Hugh', 'Jackman', 'hjackman@company.com', '650.555.0120', '2022-12-01', 'SH_CLERK', 3300, 120, 50),
(246, 'Clara', 'Oswald', 'coswald@company.com', '011.44.1344.0246', '2023-01-10', 'SA_REP', 7200, 145, 80),
(247, 'Rose', 'Tyler', 'rtyler@company.com', '011.44.1344.0247', '2023-01-20', 'SA_REP', 7100, 145, 80),
(248, 'Amy', 'Pond', 'apond@company.com', '011.44.1344.0248', '2023-02-05', 'SA_REP', 7500, 146, 80),
(249, 'Rory', 'Williams', 'rwilliams@company.com', '011.44.1344.0249', '2023-02-15', 'SA_REP', 7400, 146, 80),
(250, 'Donna', 'Noble', 'dnoble@company.com', '011.44.1344.0250', '2023-03-01', 'SA_REP', 8000, 145, 80),
(251, 'Martha', 'Jones', 'mjones@company.com', '011.44.1344.0251', '2023-03-20', 'SA_REP', 7800, 146, 80),
(252, 'Jack', 'Harkness', 'jharkness@company.com', '011.44.1344.0252', '2023-04-05', 'SA_REP', 8500, 145, 80),
(253, 'Sarah', 'Smith', 'ssmith@company.com', '011.44.1344.0253', '2023-04-15', 'SA_REP', 8200, 146, 80),
(254, 'Wilfred', 'Mott', 'wmott@company.com', '011.44.1344.0254', '2023-05-01', 'SA_REP', 6500, 145, 80),
(255, 'Mickey', 'Smith', 'msmith@company.com', '011.44.1344.0255', '2023-05-15', 'SA_REP', 6600, 146, 80),
(256, 'Bruce', 'Wayne', 'bwayne@company.com', '515.124.0256', '2020-01-01', 'FI_ACCOUNT', 8800, 108, 100),
(257, 'Clark', 'Kent', 'ckent@company.com', '515.124.0257', '2020-02-01', 'FI_ACCOUNT', 8900, 108, 100),
(258, 'Diana', 'Prince', 'dprince@company.com', '515.124.0258', '2020-03-01', 'FI_ACCOUNT', 9000, 108, 100),
(259, 'Barry', 'Allen', 'ballen@company.com', '515.124.0259', '2020-04-01', 'FI_ACCOUNT', 8700, 108, 100),
(260, 'Hal', 'Jordan', 'hjordan@company.com', '515.124.0260', '2020-05-01', 'FI_ACCOUNT', 8600, 108, 100),
(261, 'Arthur', 'Curry', 'acurry@company.com', '515.124.0261', '2020-06-01', 'AC_ACCOUNT', 8400, 205, 110),
(262, 'Victor', 'Stone', 'vstone@company.com', '515.124.0262', '2020-07-01', 'AC_ACCOUNT', 8300, 205, 110),
(263, 'Peter', 'Parker', 'pparker@company.com', '555.263', '2024-01-01', 'IT_PROG', 6500, 103, 60),
(264, 'Tony', 'Stark', 'tstark@company.com', '555.264', '2024-01-02', 'IT_PROG', 9900, 103, 60),
(265, 'Steve', 'Rogers', 'srogers@company.com', '555.265', '2024-01-03', 'AD_ASST', 4500, 101, 10),
(266, 'Natasha', 'Romanoff', 'nromanoff@company.com', '555.266', '2024-01-04', 'PR_REP', 7500, 101, 70),
(267, 'Wanda', 'Maximoff', 'wmaximoff@company.com', '555.267', '2024-01-05', 'MK_REP', 5500, 201, 20),
(268, 'Vision', 'Android', 'vision@company.com', '555.268', '2024-01-06', 'IT_PROG', 8500, 103, 60),
(269, 'Sam', 'Wilson', 'swilson@company.com', '555.269', '2024-01-07', 'MK_REP', 5200, 201, 20),
(270, 'Bucky', 'Barnes', 'bbarnes@company.com', '555.270', '2024-01-08', 'PR_REP', 6800, 101, 70),
(271, 'Scott', 'Lang', 'slang@company.com', '555.271', '2024-01-09', 'ST_CLERK', 2500, 121, 50),
(272, 'Hope', 'VanDyne', 'hvandyne@company.com', '555.272', '2024-01-10', 'ST_CLERK', 2600, 121, 50),
(273, 'TChalla', 'King', 'tchalla@company.com', '555.273', '2024-01-11', 'SA_REP', 9500, 145, 80),
(274, 'Shuri', 'Wakanda', 'shuri@company.com', '555.274', '2024-01-12', 'IT_PROG', 9800, 103, 60),
(275, 'Okoye', 'General', 'okoye@company.com', '555.275', '2024-01-13', 'SA_REP', 8800, 145, 80),
(276, 'Stephen', 'Strange', 'sstrange@company.com', '555.276', '2024-01-14', 'IT_PROG', 9000, 103, 60),
(277, 'Wong', 'Librarian', 'wong@company.com', '555.277', '2024-01-15', 'IT_PROG', 7000, 103, 60),
(278, 'Carol', 'Danvers', 'cdanvers@company.com', '555.278', '2024-01-16', 'AD_VP', 16000, 100, 90),
(279, 'Nick', 'Fury', 'nfury@company.com', '555.279', '2024-01-17', 'AD_VP', 16500, 100, 90),
(280, 'Maria', 'Hill', 'mhill@company.com', '555.280', '2024-01-18', 'AD_ASST', 5800, 101, 10),
(281, 'Phil', 'Coulson', 'pcoulson@company.com', '555.281', '2024-01-19', 'AD_ASST', 5500, 101, 10),
(282, 'Melinda', 'May', 'mmay@company.com', '555.282', '2024-01-20', 'SA_REP', 8200, 145, 80),
(283, 'Daisy', 'Johnson', 'djohnson@company.com', '555.283', '2024-01-21', 'IT_PROG', 8100, 103, 60),
(284, 'Leo', 'Fitz', 'lfitz@company.com', '555.284', '2024-01-22', 'IT_PROG', 7900, 103, 60),
(285, 'Jemma', 'Simmons', 'jsimmons@company.com', '555.285', '2024-01-23', 'IT_PROG', 7950, 103, 60),
(286, 'Grant', 'Ward', 'gward@company.com', '555.286', '2024-01-24', 'SA_REP', 7400, 145, 80),
(287, 'Bobbi', 'Morse', 'bmorse@company.com', '555.287', '2024-01-25', 'SA_REP', 8600, 146, 80),
(288, 'Lance', 'Hunter', 'lhunter@company.com', '555.288', '2024-01-26', 'SA_REP', 7200, 146, 80),
(289, 'Alphonso', 'Mackenzie', 'amack@company.com', '555.289', '2024-01-27', 'ST_MAN', 7000, 100, 50),
(290, 'Elena', 'Rodriguez', 'erodriguez@company.com', '555.290', '2024-01-28', 'ST_CLERK', 4500, 289, 50),
(291, 'Deke', 'Shaw', 'dshaw@company.com', '555.291', '2024-01-29', 'ST_CLERK', 2800, 289, 50),
(292, 'Enock', 'Chronicom', 'enock@company.com', '555.292', '2024-01-30', 'IT_PROG', 9999, 103, 60),
(293, 'Billy', 'Koenig', 'bkoenig@company.com', '555.293', '2024-02-01', 'ST_CLERK', 3500, 289, 50),
(294, 'Sam', 'Koenig', 'skoenig@company.com', '555.294', '2024-02-02', 'ST_CLERK', 3500, 289, 50),
(295, 'Eric', 'Koenig', 'ekoenig@company.com', '555.295', '2024-02-03', 'ST_CLERK', 3500, 289, 50),
(296, 'Thanos', 'Titan', 'thanos@company.com', '555.296', '2024-02-04', 'SA_MAN', 19000, 100, 80),
(297, 'Gamora', 'Zen', 'gamora@company.com', '555.297', '2024-02-05', 'SA_REP', 11000, 296, 80),
(298, 'Nebula', 'Luphomoid', 'nebula@company.com', '555.298', '2024-02-06', 'SA_REP', 10500, 296, 80),
(299, 'Peter', 'Quill', 'pquill@company.com', '555.299', '2024-02-07', 'SA_REP', 9500, 296, 80),
(300, 'Rocket', 'Raccoon', 'rocket@company.com', '555.300', '2024-02-08', 'IT_PROG', 8500, 103, 60);

/*
 * NOTE ON CIRCULAR DEPENDENCIES & DATA LOADING STRATEGY:
 * --------------------------------------------------------------------------------------------
 * This script uses a 3-step strategy to resolve the circular relationship between 
 * EMPLOYEES and DEPARTMENTS:
 * * 1. DEPARTMENTS are inserted first with NULL manager_id values. This bypasses the 
 * Foreign Key constraint that requires a Manager (Employee) to exist before 
 * the Department is created.
 * * 2. EMPLOYEES are then inserted and assigned to their respective Departments.
 * * 3. FINAL UPDATES: The UPDATE statements below close the loop by assigning the 
 * correct manager_id to each Department. 
 * * This approach ensures full Referential Integrity without needing to disable 
 * Foreign Key checks during the entire DML process.
 * --------------------------------------------------------------------------------------------
 */
UPDATE departments SET manager_id = 200 WHERE department_id = 10;
UPDATE departments SET manager_id = 201 WHERE department_id = 20;
UPDATE departments SET manager_id = 114 WHERE department_id = 30;
UPDATE departments SET manager_id = 203 WHERE department_id = 40;
UPDATE departments SET manager_id = 120 WHERE department_id = 50;
UPDATE departments SET manager_id = 103 WHERE department_id = 60;
UPDATE departments SET manager_id = 204 WHERE department_id = 70;
UPDATE departments SET manager_id = 145 WHERE department_id = 80;
UPDATE departments SET manager_id = 100 WHERE department_id = 90;
UPDATE departments SET manager_id = 108 WHERE department_id = 100;
UPDATE departments SET manager_id = 205 WHERE department_id = 110;

-- 7. Insert Job_History
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES
(101, '2005-09-21', '2010-10-27', 'AC_MGR', 110),
(101, '2010-10-28', '2015-03-15', 'AC_ACCOUNT', 110),
(101, '2013-01-01', '2015-09-20', 'AD_ASST', 10),
(102, '2009-01-01', '2011-01-12', 'IT_PROG', 60),
(102, '2001-01-13', '2006-07-24', 'IT_PROG', 60),
(103, '2014-01-01', '2016-01-02', 'IT_PROG', 60),
(104, '2016-01-01', '2017-05-20', 'ST_CLERK', 50),
(105, '2013-01-01', '2015-06-24', 'ST_CLERK', 50),
(106, '2014-01-01', '2016-02-04', 'ST_CLERK', 50),
(107, '2015-01-01', '2017-02-06', 'ST_CLERK', 50),
(108, '2010-01-01', '2012-08-16', 'FI_ACCOUNT', 100),
(109, '2010-01-01', '2012-08-15', 'AC_ACCOUNT', 110),
(110, '2013-01-01', '2015-09-27', 'AC_ACCOUNT', 110),
(111, '2013-01-01', '2015-09-29', 'AC_ACCOUNT', 110),
(112, '2014-01-01', '2016-03-06', 'AC_ACCOUNT', 110),
(113, '2015-01-01', '2017-12-06', 'AC_ACCOUNT', 110),
(114, '2010-01-01', '2012-12-06', 'PU_CLERK', 30),
(115, '2011-01-01', '2013-05-17', 'ST_CLERK', 50),
(116, '2013-01-01', '2015-12-23', 'ST_CLERK', 50),
(117, '2013-01-01', '2015-07-23', 'ST_CLERK', 50),
(118, '2014-01-01', '2016-11-14', 'ST_CLERK', 50),
(119, '2015-01-01', '2017-08-09', 'ST_CLERK', 50),
(120, '2012-01-01', '2014-07-17', 'ST_CLERK', 50),
(121, '2013-01-01', '2015-04-09', 'ST_CLERK', 50),
(122, '2014-01-01', '2016-07-17', 'SH_CLERK', 50),
(123, '2013-01-01', '2015-10-09', 'SH_CLERK', 50),
(124, '2015-01-01', '2017-11-15', 'SH_CLERK', 50),
(145, '2012-01-01', '2014-09-30', 'SA_REP', 80),
(146, '2013-01-01', '2015-01-04', 'SA_REP', 80),
(150, '2013-01-01', '2015-01-29', 'SA_REP', 80),
(151, '2013-01-01', '2015-03-23', 'SA_REP', 80),
(152, '2014-01-01', '2015-08-19', 'SA_REP', 80),
(153, '2014-01-01', '2016-03-29', 'SA_REP', 80),
(154, '2015-01-01', '2016-12-08', 'SA_REP', 80),
(155, '2015-01-01', '2017-11-22', 'SA_REP', 80),
(201, '2011-01-01', '2014-02-16', 'MK_REP', 20),
(202, '2013-01-01', '2015-08-16', 'AD_ASST', 10),
(203, '2010-01-01', '2012-06-06', 'AD_ASST', 10),
(204, '2010-01-01', '2012-06-06', 'AD_ASST', 10),
(212, '2018-01-01', '2020-01-04', 'ST_CLERK', 50),
(213, '2018-01-01', '2020-01-05', 'ST_CLERK', 50),
(214, '2018-01-01', '2020-01-06', 'ST_CLERK', 50),
(215, '2018-01-01', '2020-01-07', 'ST_CLERK', 50),
(218, '2019-01-01', '2021-01-14', 'ST_CLERK', 50),
(219, '2019-01-01', '2021-02-09', 'ST_CLERK', 50),
(220, '2019-01-01', '2021-03-04', 'ST_CLERK', 50),
(221, '2019-01-01', '2021-04-11', 'ST_CLERK', 50),
(226, '2020-01-01', '2022-01-09', 'SH_CLERK', 50),
(227, '2020-01-01', '2022-01-14', 'SH_CLERK', 50),
(228, '2020-01-01', '2022-01-31', 'SH_CLERK', 50),
(229, '2020-01-01', '2022-02-09', 'ST_CLERK', 50),
(230, '2020-01-01', '2022-03-04', 'ST_CLERK', 50),
(256, '2018-01-01', '2019-12-31', 'AC_ACCOUNT', 110),
(257, '2018-01-01', '2020-01-31', 'AC_ACCOUNT', 110),
(258, '2018-01-01', '2020-02-28', 'AC_ACCOUNT', 110),
(263, '2023-01-01', '2023-12-31', 'ST_CLERK', 50),
(264, '2023-01-01', '2023-12-31', 'ST_CLERK', 50),
(265, '2023-01-01', '2023-12-31', 'ST_CLERK', 50),
(266, '2023-01-01', '2023-12-31', 'SA_REP', 80),
(267, '2023-01-01', '2023-12-31', 'SA_REP', 80),
(268, '2023-01-01', '2023-12-31', 'SA_REP', 80),
(269, '2023-01-01', '2023-12-31', 'IT_PROG', 60),
(270, '2023-01-01', '2023-12-31', 'IT_PROG', 60),
(283, '2022-01-01', '2024-01-20', 'ST_CLERK', 50),
(284, '2022-01-01', '2024-01-21', 'ST_CLERK', 50),
(285, '2022-01-01', '2024-01-22', 'ST_CLERK', 50),
(286, '2022-01-01', '2024-01-23', 'ST_CLERK', 50),
(287, '2022-01-01', '2024-01-24', 'ST_CLERK', 50),
(296, '2023-01-01', '2024-01-31', 'SA_REP', 80),
(297, '2023-01-01', '2024-02-04', 'SA_REP', 80),
(298, '2023-01-01', '2024-02-05', 'SA_REP', 80),
(299, '2023-01-01', '2024-02-06', 'SA_REP', 80),
(300, '2023-01-01', '2024-02-07', 'IT_PROG', 60);

COMMIT;

/********************************************************
 * POST UPLOAD DATA VALIDATION
********************************************************/
SELECT 'regions', COUNT(*) FROM regions
UNION ALL
SELECT 'countries', COUNT(*) FROM countries
UNION ALL
SELECT 'locations', COUNT(*) FROM locations
UNION ALL
SELECT 'departments', COUNT(*) FROM departments
UNION ALL
SELECT 'jobs', COUNT(*) FROM jobs
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'job_history', COUNT(*) FROM job_history;




