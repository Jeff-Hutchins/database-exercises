-- 3.7_group_by_exerxcises.sql
select * from titles;

-- use DISTINCT to find unique titles in the titles tables
select distinct title from titles

select * from employees;

-- Update query for employees whose last name starts and ends with 'E' to find just the unique last names that start and end with 'E'.
SELECT distinct last_name  
FROM employees 
WHERE last_name
like 'e%e'
GROUP BY last_name;

-- Update previous query to find unique combos of first and last name.
SELECT distinct last_name, first_name 
FROM employees 
WHERE last_name
like 'e%e';

-- Find unique last names with a 'q' but not'qu'.
SELECT distinct last_name 
FROM employees 
WHERE last_name 
LIKE ('%q%') 
AND last_name 
NOT LIKE ('%qu%');

-- Add a COUNT() to results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT distinct last_name, count(*)
FROM employees 
WHERE last_name 
LIKE ('%q%') 
AND last_name 
NOT LIKE ('%qu%')
GROUP BY last_name
ORDER BY count(*);

-- Update query for names using COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT count(*), gender
FROM employees 
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') 
GROUP BY gender
ORDER BY count(*) DESC;

-- Recall the query that generated usernames for the employees from the last exercise.  Are there duplicate names?  YES
SELECT 
	lower(
		concat(
			substring(first_name,1,1), 
			substring(last_name,1,4),
 			'_', 
 			substring(birth_date,-5,2), 
 			substring(birth_date,3,2)
 		)
 	) as username,
 	count(*)
 from employees
 group by username
 order by count(*) DESC;