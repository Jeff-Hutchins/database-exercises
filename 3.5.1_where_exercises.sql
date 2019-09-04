use employees;

SELECT * FROM employees;

-- Find all employees with first names 'Irena', 'Vidya', 'Maya'.
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- Update your query for 'Irena', 'Vidya', or 'Maya'.
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- Add a condition to the previous query to find everybody with those names who is also male.
SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender='M';

-- Find all employees whose last name starts with 'E'.
SELECT * FROM employees WHERE last_name LIKE ('E%');
-- Find all employees whose last name starts or ends with 'E'.
SELECT * FROM employees WHERE last_name LIKE ('E%') OR last_name LIKE ('%E');
-- Duplicate the previous query and update it to find all employees whos last name starts and ends with 'E'.
SELECT * FROM employees WHERE last_name LIKE ('E%') AND last_name LIKE ('%E');

-- Find all employees hired in the 90s.
SELECT * FROM employees WHERE hire_date>'1990' AND hire_date<'2000';
-- Find all employees born on christmas.
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
-- Find all employees born on christmas and hired in the 90s.
SELECT * FROM employees WHERE (hire_date>'1990' AND hire_date <'2000') AND birth_date LIKE '%-12-25';

-- Find all employees with a 'q' in their last name.
SELECT * FROM employees WHERE last_name LIKE ('%q%');
-- Find all employees with a 'q' in their last name but not 'qu'.
SELECT * FROM employees WHERE last_name LIKE ('%q%') AND last_name NOT LIKE ('%qu%');