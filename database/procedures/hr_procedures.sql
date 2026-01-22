
/**********************************************************************************************
 * Project        : HR Schema (Based on Oracle HR Sample Schema)
 * Script Name    : hr_procedures.sql
 * Description    : Implementation of stored procedures for business logic and CRUD operations
 *
 * Database       : MySQL
 * Database Engine: InnoDB
 * Database Host  : Aiven - MySQL
 * Schema Name    : HR
 *
 * Author         : PaKo Araya
 * E-mail         : fraxxxxxxh@gmail.com
 * Company        : [Your Company or Personal Project]
 * Created Date   : 2026-01-22
 * Last Modified  : 2026-01-22
 *
 * Script Version : 1.0.0
 * Database Version Tested: MySQL 8.0.35
 * Charset        : utf8mb4
 * Collation      : utf8mb4_general_ci
 *
 * Dependencies   : 
 * - hr_tables.sql
 * - hr_data_seed.sql
 *
 * Execution Tool : DBeaver / MySQL CLI
 * Environment    : [x]Development | [-]Test | [-]Production
 * Execution Mode : Manual / Application Call
 * Backup Needed  : Yes (Before executing procedures that modify data)
 * Rollback Plan  : DROP PROCEDURE [procedure_name] / Reverse DML
 * Estimated Time : < 1 minute (Creation)
 * Risk Level     : Medium (Procedures can modify table states)
 *
 * Purpose        : Encapsulate repetitive tasks and ensure data integrity through server-side logic
 * Compatibility  : MySQL 8.0+
 * Transactional  : Yes (Where explicitly defined with START TRANSACTION)
 * Idempotent     : Yes (Uses DROP PROCEDURE IF EXISTS)
 *
 * Change Log:
 * --------------------------------------------------------------------------------------------
 * Version | Date       | Author      | Description
 * --------------------------------------------------------------------------------------------
 * 1.0.0   | 2026-01-22 | P. Araya    | Initial version - Core HR Business Logic
 *
 **********************************************************************************************/

/* 001
 sp_promote_employee: A procedure that receives p_employee_id and p_new_job_id. It must:
	o	Insert the current record into job_history.
	o	Update job_id and hire_date (current date) in the employees table.
*/

/*
Why did we use this approach?
The INSERT INTO ... SELECT Pattern: This is the most efficient method. You are 
telling MySQL: "Insert into Table A whatever you find in Table B for this specific ID." 
This bypasses the need to declare multiple local variables to store data temporarily, 
reducing memory overhead and code complexity.

CURDATE() Function: We use the system's current date to simultaneously mark the end of 
the old role (in job_history) and the start of the new one (in employees).

Data Integrity: By using a SELECT statement inside the INSERT, if the p_employee_id does 
not exist, the query returns an empty set. Consequently, nothing is inserted into the 
history table, preventing "orphaned" or "garbage" records.
*/

/****************************
 * Option A
*****************************/

USE hr;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_promote_employee //

CREATE PROCEDURE sp_promote_employee(
    IN p_employee_id INT,
    IN p_new_job_id  VARCHAR(10) 
)
BEGIN 
    /* 1. Backup current employee data into job_history.
          We pull the department and the old hire_date directly from the 
          employees table before they get updated.
    */
    INSERT INTO job_history (
        employee_id,
        start_date,
        end_date,
        job_id,
        department_id
    )
    SELECT 
        employee_id, 
        hire_date,     -- Former start date
        CURDATE(),     -- Termination date of the current role
        job_id, 
        department_id 
    FROM employees 
    WHERE employee_id = p_employee_id;

    /* 2. Update the employee record with the new Job ID 
          and reset the hire_date to today.
    */
    UPDATE employees 
    SET 
        job_id = p_new_job_id,
        hire_date = CURDATE() 
    WHERE employee_id = p_employee_id;

END //

DELIMITER ;

/****************************
 * Option B
*****************************/
DELIMITER //

DROP PROCEDURE IF EXISTS sp_promote_employee //

CREATE PROCEDURE sp_promote_employee(
    IN p_employee_id INT,
    IN p_new_job_id  VARCHAR(10) 
)
BEGIN 
    -- 1. VALIDATION: Check if the new Job ID actually exists
    IF NOT EXISTS (SELECT 1 FROM jobs WHERE job_id = p_new_job_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: The provided Job ID does not exist in the Jobs table.';
    END IF;

    -- 2. VALIDATION: Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Employee ID not found.';
    END IF;

    -- [Rest of your INSERT and UPDATE logic goes here...]
    INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
    SELECT employee_id, hire_date, CURDATE(), job_id, department_id 
    FROM employees WHERE employee_id = p_employee_id;

    UPDATE employees 
    SET job_id = p_new_job_id, hire_date = CURDATE() 
    WHERE employee_id = p_employee_id;

END //

DELIMITER ;


/****************************
 * Option C
*****************************/
DELIMITER //

DROP PROCEDURE IF EXISTS sp_promote_employee //

CREATE PROCEDURE sp_promote_employee(
    IN p_employee_id INT,
    IN p_new_job_id  VARCHAR(10) 
)
BEGIN 
    -- 1. VALIDATION: Job Existence
    IF NOT EXISTS (SELECT 1 FROM jobs WHERE job_id = p_new_job_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: The provided Job ID does not exist in the Jobs table.';
    END IF;

    -- 2. VALIDATION: Employee Existence
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Employee ID not found.';
    END IF;

    -- 3. VALIDATION: Prevent promoting to the same job (evita el error 1062)
    IF EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id AND job_id = p_new_job_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Employee already holds this job position.';
    END IF;

    -- START TRANSACTION: Todo o nada
    START TRANSACTION;

        -- Backup current data to history
        INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        SELECT employee_id, hire_date, CURDATE(), job_id, department_id 
        FROM employees 
        WHERE employee_id = p_employee_id;

        -- Update employee to new role
        UPDATE employees 
        SET job_id = p_new_job_id, hire_date = CURDATE() 
        WHERE employee_id = p_employee_id;

    COMMIT; -- Confirmamos los cambios

END //

DELIMITER ;

-- ============================================================================================
-- VALIDATION / TESTING
-- ============================================================================================

-- Step 1: Check current status of the employee
SELECT employee_id, job_id, hire_date FROM employees WHERE employee_id = 102;


-- Step 2: Execute the promotion
-- 2.1. Clear the history for this specific employee to start fresh
DELETE FROM job_history WHERE employee_id = 206;

-- 2.2. Reset the employee to a clean state (optional but helpful)
UPDATE employees 
SET job_id = 'AC_ACCOUNT', hire_date = '2012-06-07' 
WHERE employee_id = 206;

-- 2.3. NOW, run the promotion to a NEW role (IT_PROG)
CALL sp_promote_employee(206, 'IT_PROG');

-- 2.4. CHECK THE RESULTS
-- This should show the OLD job (AC_ACCOUNT)
SELECT * FROM job_history WHERE employee_id = 206;

-- This should show the NEW job (IT_PROG) and TODAY'S date
SELECT employee_id, job_id, hire_date FROM employees WHERE employee_id = 206;


-- Step 3: Verify that history was created and the employee record was updated
-- 3.1 Clean the History (Remove the "failed" test record):
DELETE FROM job_history 
WHERE employee_id = 102 AND start_date = '2011-01-13';

-- 3.2 2. Execute the Promotion to a DIFFERENT job: Let's promote Lex De Haan (102) 
-- from AD_VP to AD_PRES (President):
CALL sp_promote_employee(102, 'AD_PRES');

-- 3.3 Run the Verification again:
-- This should now show the OLD job (AD_VP) ending TODAY
SELECT * FROM job_history WHERE employee_id = 102;

-- This should now show the NEW job (AD_PRES) starting TODAY
SELECT employee_id, job_id, hire_date FROM employees WHERE employee_id = 102;


-- =================================================================================


/* 002
sp_adjust_department_salary: Receives a department_id and a percentage 
(e.g., 0.10 for 10%). It increases the salary of all employees in that department 
but validates that the new salary does not exceed the max_salary defined in 
the jobs table.
*/















