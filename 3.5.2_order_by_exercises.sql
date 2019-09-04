-- 3.5.2_order_by_exercises.sql

-- Modify query to order by first name.
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;

-- Update query to order by first name and then last name.
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name ASC, last_name ASC;

-- Change the order by clause so that you order by last name before first name
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name ASC, first_name ASC;

-- Update query for employees with 'E' in their last name to sort for results by their employee number.
SELECT * FROM employees WHERE last_name LIKE ('E%') ORDER BY emp_no;

-- Now reverse the sort order for both queries.
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name DESC, first_name DESC;
SELECT * FROM employees WHERE last_name LIKE ('E%') ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last.
SELECT * FROM employees WHERE (hire_date>'1990' AND hire_date <'2000') AND birth_date LIKE '%-12-25' ORDER BY birth_date ASC, hire_date DESC;
