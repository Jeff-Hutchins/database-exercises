-- 3.6_functons_exercises.sql

use employees;

-- Update your queries for employuees whos names start and end with 'E'.  Use concat() to combien their first and last names together as a single column named full_name.
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM employees WHERE CONCAT(first_name,' ',last_name) like 'e%e';

-- Convert the names produced in previous query to all uppercase.
SELECT UPPER(CONCAT(first_name,' ',last_name)) AS full_name FROM employees WHERE CONCAT(first_name,' ',last_name) like 'e%e';

-- For query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company.
SELECT datediff(curdate(), hire_date) as days_with_company, first_name, last_name from employees
WHERE hire_date>'1990' AND hire_date <'2000' 
AND birth_date LIKE '%-12-25'
order by days_with_company DESC;

-- Find the smallest and largest salary from the salaries table.
SELECT MAX(salary) as 'largest_salary', MIN(salary) as 'smallest_salary', avg(salary) as 'average_salary'
FROM salaries;

-- Generate a username for all of the employees.

SELECT 
	lower(
		concat(
			substring(first_name,1,1), 
			substring(last_name,1,4),
 			'_', 
 			substring(birth_date,-5,2), 
 			substring(birth_date,3,2)
 		)
 	), 
 first_name, 
 last_name, 
 birth_date 
 from employees;