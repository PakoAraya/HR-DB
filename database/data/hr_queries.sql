
/**********************************************************************************************
 * Project        : HR Schema (Based on Oracle HR Sample Schema)
 * Script Name    : hr_queries.sql
 * Description    : SQL Training Lab: Joins, Subqueries, Aggregations, and Analytics.
 *
 * Database       : MySQL 8.0.35
 * Schema Name    : hr
 *
 * Author         : PaKo Araya
 * E-mail         : fraxxxxxxh@gmail.com
 * Created Date   : 2026-01-18
 * Last Modified  : 2026-01-18
 *
 * Script Version : 1.0.0
 * Risk Level     : Low (Read-only / DQL)
 *
 * Purpose        : 
 * - Practice advanced SQL querying techniques.
 * - Analyze employee, department, and location data.
 * - Develop reporting skills using MySQL extensions.
 *
 * Exercises Included:
 * - [ ] Basic SELECT & Filtering
 * - [ ] Multi-table JOINs (Inner, Left, Right)
 * - [ ] Aggregate Functions (GROUP BY, HAVING)
 * - [ ] Subqueries & CTEs (Common Table Expressions)
 * - [ ] Window Functions (RANK, ROW_NUMBER)
 *
 * Notes:
 * - These queries are designed for the 'hr' database.
 * - Does not modify data (Read-only).
 **********************************************************************************************/

-- Set environment
USE hr;

-- =====================================================================
-- LAB 01: BASIC QUERIES EXERCISEs
-- Goal: Learn best practices for declaring queries in databases
-- =====================================================================

/* 001
Develop a query that list the employee's name, department code and de  
hire date, sorting the results by departments and hire date with the most
recent hire appearing first
*/
SELECT  e.first_name, e.department_id, e.hire_date 
FROM employees e 
ORDER BY e.department_id, e.hire_date DESC ;


/* 002
 Develop a query that list employee's code, first and last names of the employees, and 
 their respective managers, along with the titles of the employee and manager
 boss, with job title and manager
 */
SELECT e1.employee_id ||' - '|| e1.first_name ||' '|| e1.last_name AS Employee, 
e2.employee_id ||' - '|| e2.first_name ||' '|| e2.last_name AS Manager
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id ;

-- Another Way
SELECT e1.employee_id ||' - '|| e1.first_name ||' '|| e1.last_name AS Employee, 
e2.employee_id ||' - '|| e2.first_name ||' '|| e2.last_name AS Manager
FROM employees e1
JOIN employees e2
  ON e1.manager_id = e2.employee_id


/* 003
 Develop a query that list all countries by region. The data to be displayed is the region's code
 and region's name, with the names of its countries.
 */
SELECT r.region_id, r.region_name, c.country_name 
FROM regions r 
JOIN countries c
ON  r.region_id = c.region_id 


/* 004
 Run a query that displays employee's id, first and last names, start and end date of
 the employee's job history
 */
SELECT e.employee_id, e.first_name, e.last_name, jh.start_date, jh.end_date 
FROM employees e 
JOIN job_history jh ON e.employee_id = jh.employee_id ;

/* 005
 Create a query that displays the employee's first and last names, with the title 
 "Employee", their salary, commission percentage, commission and total salary
 */
SELECT 
    -- Concatenate names to create a single employee string
    CONCAT(e.first_name, ' ', e.last_name) AS Employee, 
    e.salary AS Base_Salary, 
    e.commission_pct AS Commission_Rate,
    -- Calculate the actual commission amount (handling potential NULLs)
    COALESCE(e.salary * e.commission_pct, 0) AS Commission_Amount,
    -- Final calculation: Base Salary + Calculated Commission
    e.salary + COALESCE(e.salary * e.commission_pct, 0) AS Total_Salary
FROM employees e
-- Order by the highest earners
ORDER BY Total_Salary DESC;


/* 006
 Create a query that list the job title and salary of employees who are
 managers, whose code is 100 or 125, and whose salary is greater than 
 6000
 */
SELECT j.job_title, e.salary 
FROM employees e 
JOIN jobs j ON e.job_id = j.job_id 
WHERE e.employee_id = 100 OR e.employee_id = 125 AND e.salary > 6000;









