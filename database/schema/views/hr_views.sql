
/**********************************************************************************************
 * Project        : HR Schema (Based on Oracle HR Sample Schema)
 * Script Name    : hr_views.sql
 * Description    : Implementation of analytical and reporting views
 *
 * Database       : MySQL
 * Database Engine: InnoDB
 * Database Host  : Aiven - MySQL
 * Schema Name    : HR
 *
 * Author         : PaKo Araya
 * E-mail         : fraxxxxxxh@gmail.com
 * Company        : [Your Company or Personal Project]
 * Created Date   : 2026-01-21
 * Last Modified  : 2026-01-21
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
 * Execution Mode : Manual
 * Backup Needed  : No (Views are virtual)
 * Rollback Plan  : DROP VIEW [view_name]
 * Estimated Time : < 1 minute
 * Risk Level     : Low
 *
 * Purpose        : Simplify complex reporting and abstract joins for the application layer
 * Compatibility  : MySQL 8.0+ (Uses CTE for recursive views)
 * Transactional  : N/A
 * Idempotent     : Yes (Uses OR REPLACE)
 *
 * Change Log:
 * --------------------------------------------------------------------------------------------
 * Version | Date       | Author      | Description
 * --------------------------------------------------------------------------------------------
 * 1.0.0   | 2026-01-21 | P. Araya    | Initial version - v_employee_details, v_dept_stats, v_chain
 *
 **********************************************************************************************/

/* 001
 ·	v_employee_full_details: A view that joins all tables to show: Full Name, Job Title, 
 Department, City, Country, and Region.
*/
USE hr;

CREATE OR REPLACE VIEW v_employee_full_details AS 
SELECT 
	e.employee_id,
	CONCAT(e.first_name, ' ', e.last_name) AS 'Full Name',
	e.email,
	j.job_title,
	d.department_name,
	l.city,
	c.country_name,
	r.region_name 
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id 
LEFT JOIN countries c ON l.country_id = c.country_id 
LEFT JOIN regions r ON c.region_id = r.region_id
ORDER BY e.employee_id ;

-- Validate
SELECT * FROM v_employee_full_details;

SELECT * FROM v_employee_full_details 
WHERE city = 'Oxford';

/* 002
 v_department_stats: A view showing for each department: total employees, 
 sum of salaries, average salary, and the manager's name.
*/
USE hr;

CREATE OR REPLACE VIEW v_department_stats AS 
SELECT 
    d.department_id,
    d.department_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    COUNT(e.employee_id) AS 'Total Employees',
    SUM(e.salary) AS 'Total Salary Cost',
    ROUND(AVG(e.salary), 2) AS 'Average Salary'
FROM departments d
LEFT JOIN employees m ON d.manager_id = m.employee_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, manager_name;

-- Validate
SELECT * FROM v_department_stats;

SELECT * FROM v_department_stats 
WHERE total_employees > 5;

/* 003
 v_management_chain: A recursive view (or one that simulates hierarchy) showing 
 each employee along with their direct supervisor and their supervisor's boss.
*/
USE hr;

CREATE OR REPLACE VIEW v_management_chain AS
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee,
    j.job_title AS employee_role,
    CONCAT(m.first_name, ' ', m.last_name) AS direct_manager,
    CONCAT(gm.first_name, ' ', gm.last_name) AS top_manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
LEFT JOIN employees gm ON m.manager_id = gm.employee_id
LEFT JOIN jobs j ON e.job_id = j.job_id;

-- Validate 
SELECT * FROM v_management_chain;

SELECT * FROM v_management_chain 
WHERE direct_manager IS NULL;

















