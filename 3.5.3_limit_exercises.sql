-- 3.5.3_limit_exercisese.sql

-- using 'employees' table.
SELECT DISTINCT title FROM titles;

-- List the first 10 distinct last names sorted in descending order.
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

-- Update hire_date/christmas query to find just the first 5 employees.
SELECT * FROM employees WHERE (hire_date>'1990' AND hire_date <'2000') AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date DESC LIMIT 5;

-- Update query to find the tenth page of results.
SELECT * FROM employees WHERE (hire_date>'1990' AND hire_date <'2000') AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date DESC LIMIT 5 OFFSET 45;

-- What is the relationship between OFFSET, LIMIT, and page number?
-- OFFSET / LIMIT = number of pages