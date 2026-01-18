
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









