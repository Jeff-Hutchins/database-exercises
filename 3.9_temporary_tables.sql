-- 3.9_temporary_tables.sql
use bayes_820;
-- Using the exaple from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

show create table employees_with_departments;

-- Update table so that full name column contains the correcrt data.
update employees_with_departments
set full_name = concat(first_name,' ', last_name);

-- Remove the first_name and last_name columns from table.
alter table employees_with_departments drop last_name;
alter table employees_with_departments drop first_name;

-- What is another way to have ended up with this same table?
--	Could specify the code within the create temporary table to create full_name.
select * from employees_with_departments;

-- Ceate a temporary table based on the payment table from sakila database.
-- Write the SQL necessar to transform the amount column such that it is stored as an integer representing the number of cents of the payment.
use sakila;
select * from payment;


use bayes_820;

CREATE TEMPORARY TABLE sakila_payment AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment;

update sakila_payment
set amount = amount * 100;

show create table sakila_payment;

alter table sakila_payment add column amount_cents int;
update sakila_payment
set amount_cents = amount * 100;

select * from sakila_payment;

-- Find out how the average pay in each department compares to the overall average pay.
-- In order to make it easier, use Z-score for salaries.
-- In terms of salary, what is the best department to work for? The worst?

use employees;
select * from departments;
select * from salaries;
select * from dept_emp;

use bayes_820;

CREATE TEMPORARY TABLE employees_combineed AS
SELECT dept_name, emp_no, dept_no, salary
FROM employees.departments
JOIN employees.dept_emp USING(dept_no)
JOIN employees.salaries USING(emp_no);

select * from employees_combineed;