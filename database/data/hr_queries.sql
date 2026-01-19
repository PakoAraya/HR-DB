
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

-- Another Way
SELECT j.job_title, e.salary 
FROM employees e 
JOIN jobs j ON e.job_id = j.job_id 
WHERE e.employee_id IN (100,125) AND e.salary > 6000;


/* 007 
 Develop a query that list the locality code, city, and department name 
 only for those located outside the United States (US)
*/



/* 008
 Performa a query that displays the region code, region name and the 
 names of the countries names located in "Asia".
*/



/* 009
 Create a query that list the region code, the region name, locality code
 city and country name for only those localities larger than 2400.
*/



/* 010
 Develop a query that displays the region code with a region alias, the region 
 name with a “region name” label, and a string (concatenation) that says the 
 following phrase: “Country Code: CA Name: Canada,” where CA is the country 
 code and Canada is the country name with the country label. the location code 
 with the Location label, the street address with the Address label, and the 
 postal code with the “Postal Code” label. In turn, postal codes that are null 
 should not appear.
*/



/* 011
 Develop a query that displays the average salary of employees in departments 
 30 and 80
*/



/* 012
 Develop a query that displays the name of the region, the name of the country,
 the state of the province, the code of the employee who are managers, and the
 first and last names of employees who are managers in the United Kingdom (UK)
 and the United States (US), respectively, in the states of Washington and 
 Oxford.
*/



/* 013
 Perform a query that displays the first and last names of employees who work 
 for departments located in countries whose names begin with the letter C, showing 
 the name of the country.
*/



/* 014
 Develop a query that lists the job title, the first and last name of the 
 employee who holds that position, whose email is ‘NKOCHHAR’, on September 21, 1989.
*/



/* 015
 Write a single query that lists employees in departments 10, 20, and 80 who 
 were hired more than 180 days ago, earn a commission of at least 20%, and 
 whose first or last name begins with the letter ‘J’.
*/



/* 016
 Perform a query that displays the first name, last name, and department name of 
 employees whose phone number has the area code 515 (12-digit number: 3 area 
 code digits, 7 number digits, and a colon), excluding phone numbers that are 
 not 12 characters long.
*/



/* 017
 Develop a query that displays the code, first and last name separated by a 
 comma with the header title “full name,” the salary with the title “salary,” 
 the department code with the title “department code,” and the name of the 
 department to which they belong with the title “description.” Only queries 
 belonging to the IT department are desired, and the information should be 
 sorted by descending salary.
*/



/* 018
  Perform a query that lists the first and last name, salary of the employee, 
  the name of the department to which they belong, the address, the zip code, 
  and the city where the department is located. Only those from departments 
  100, 80, and 50, respectively, should be displayed. They must also belong 
  only to the city of South San Francisco, and the salary range must be 
  between 4000 and 8000, including the limit values.
*/



/* 019
 Develop a query where you select the employee code, whose alias will be code, 
 the last name concatenated with the employee's first name but separated by a 
 comma (,), whose alias will be Names, the email where the initial is 
 capitalized and all have the domain @eisi.ues.edu.sv, that is, it must be 
 concatenated with that domain, whose alias is email, In addition, if the phone 
 number is stored in the field in this way, 515.123.4567, it must be converted 
 to the following format (515)-123-4567. If you have a phone number with this 
 length, 011.44.1344.429268, i.e., longer than the previous format, it should 
 appear in the following format (011-44-1344-429268). Queries you can make using 
 functions for this exercise, such as LENGTH and SUBSTR. This information should 
 be sorted by employee code.
*/



/* 020
 Develop a query that allows you to select cities, their country code, and if it 
 is from the United Kingdom (UK), change it to (UNKing); otherwise, if it is not 
 from the United Kingdom (Non-UNKing), cities must start with the letter S.
*/



/* 021
  Develop a query that displays the department code with the title “Department Code,” 
  counting the employees grouped by department, sorted by department code.
*/



/* 022
  Run a query that shows only the names of employees that are repeated.
*/



/* 023
 Develop a query that displays only the names of employees that are not repeated.
*/



/* 024
 Perform a query that shows the number of countries per region. The query should 
 show the code and name of the region, as well as the number of countries in each 
 region, sorting the results by the region with the highest number of countries.
*/



/* 025
 Develop a query that lists the job codes with the number of employees belonging 
 to each job, sorted by the number of employees. The jobs with the most employees 
 appear first.
*/



/* 026
  Develop a query that displays the number of employees per department, sorted 
  alphabetically by department name.
*/



/* 027
  Perform a query that shows the number of departments per region.
*/



/* 028
  Run a query that shows the salary paid by each department (excluding commissions), 
  sorted in descending order by salary paid. The code and name of the department 
  and the salary paid will be displayed.
*/



/* 029
  Develop a query that displays the year of hire, the lowest, highest, and average 
  salary for all employees by year of hire. Sort the results by year of hire 
  (most recent first).
*/



/* 030
  Develop a query that displays the department code with the title “Department Code,” 
  the job code with the title “Job Position,” and counts the employees in departments 
  50 and 80, sorting the results by department and job position.
*/



/* 031
  Develop a query that lists the department code with the title “Department Code,” 
  the job code with the title “Job Position,” and counts the employees by department 
  and job position, where the job position has only one employee in the company.
*/



/* 032
  Perform a query that lists the number of employees per city who earn at least $5,000 
  in salary. Omit cities that have fewer than 3 employees with that salary.
*/



/* 033
  Create a query that displays the department code with the title “Department Code,” 
  counting the employees per department for those departments that have more than 
  10 employees.
*/



/* 034
  Develop a query that lists the last name, first name, and salary of the employee 
  with the highest salary in all departments.
*/



/* 035
  Develop a query that displays the department code, first name, and last name of 
  employees only from departments where there are employees named ‘John’.
*/



/* 036
  Develop a query that lists the department code, first name, last name, and salary 
  of only the highest-paid employees in each department.
*/



/* 037
  Create a query that displays the department code, department name, and maximum 
  salary for each department.
*/



/* 038
  Find all records in the employees table that contain a value that occurs twice 
  in a given column.
*/



/* 039
  Run a query that lists employees who are in departments with fewer than 10 employees.
*/



/* 040
  Develop a query that shows the highest salary among employees working in department 
  30 (department_id) and which employees earn that salary.
*/



/* 041
  Create a query that shows the departments where there are no employees.
*/



/* 042
  Develop a query that shows all employees who are not working in department 30 and 
  who earn more than all employees working in department 30.
*/



/* 043
  Perform a query that shows employees who are managers (manager_id) and the number 
  of employees reporting to each one, sorted in descending order by number of subordinates. 
  Exclude managers who have 5 or fewer employees reporting to them.
*/



/* 044
  Develop a query that displays the employee code, last name, salary, region name, 
  country name, province status, department code, and department name where the 
  following conditions are met:
	a) The employees you select have a salary higher than the average for their department.
	b) Do not select those from the state of Texas.
	c) Sort the information by employee code in ascending order.
	d) Do not select those from the finance department.
*/

















