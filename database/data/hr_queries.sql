
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
-- LAB 01: BASIC JOIN EXERCISE
-- Goal: List all employees with their department names and city.
-- =====================================================================

/* Your first query could go here:
SELECT 
    e.first_name, 
    e.last_name, 
    d.department_name, 
    l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
*/















