
	
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
describe employees_with_departments;
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

/* Find out how the average pay in each department compares to the overall average pay.
In order to make it easier, use Z-score for salaries.
In terms of salary, what is the best department to work for? The worst? */

use employees;
select * from departments;
select * from salaries;
select * from dept_emp;

use bayes_820;


		-- Created table for average salaries by department name.
CREATE TEMPORARY TABLE employees_comb5 AS
SELECT dept_name, avg(salaries.salary) as dept_mean, std(salaries.salary) as std_dev, avg(salaries.salary) as mean
FROM employees.departments
JOIN employees.dept_emp USING(dept_no)
JOIN employees.salaries USING(emp_no)
where dept_emp.to_date = '9999-01-01'
group by dept_name;

		-- Created temporary table for average salary across all jobs salaries.
create temporary table salary2
select avg(salaries.salary) as mean
from employees.salaries
where to_date = '9999-01-01';

select * from salary2;

		-- Updated temp table employees_comb5 with the average salary(mean) across all job salaries.
update employees_comb5
set mean = 72012.2359;

		-- Created temp table for standard deviation of salaries across all job salaries.
create temporary table std_dev2
select std(salaries.salary) as std_dev
from employees.salaries
where to_date = '9999-01-01';

select * from std_dev2;

		-- Updated temp table employees_comb5 with the std dev of salaries across all job salaries.
update employees_comb5
set std_dev = 17309.95933634675;

select * from employees_comb5; 

		-- calculated z_scores based on previous calculations.
select dept_name, ((dept_mean - mean) / std_dev) as z_score
from employees_comb5;
