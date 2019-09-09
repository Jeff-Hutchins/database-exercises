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
CREATE TEMPORARY TABLE employees_comb3 AS
SELECT dept_name, avg(salaries.salary) as dept_mean, std(salaries.salary) as std_dev, avg(salaries.salary) as mean
FROM employees.departments
JOIN employees.dept_emp USING(dept_no)
JOIN employees.salaries USING(emp_no)
-- where dept_emp.to_date = '9999-01-01'
group by dept_name;

select * from employees_comb3;

		-- Created temporary table for average salary across all jobs salaries.
create temporary table salary3
select avg(salaries.salary) as mean
from employees.salaries;
-- where to_date = '9999-01-01'

select * from salary3;

		-- Updated temp table employees_comb5 with the average salary(mean) across all job salaries.
update employees_comb3
set mean = 63810.7448;

		-- Created temp table for standard deviation of salaries across all job salaries.
create temporary table std_dev3
select std(salaries.salary) as std_dev
from employees.salaries;
-- where to_date = '9999-01-01'

select * from std_dev3;

		-- Updated temp table employees_comb5 with the std dev of salaries across all job salaries.
update employees_comb3
set std_dev = 16904.82828800014;

select * from employees_comb3; 

		-- calculated z_scores based on previous calculations.
select dept_name, ((dept_mean - mean) / std_dev) as z_score
from employees_comb2;

		/* The best department to work for is the sales department with a z_score of 0.527.
		The worst department to work for is Human Resources with a z_score -0.915 */



/* What is the average salarhy for an employee based on the number of years they have been with the company?  In terms of z_score of salary.
Scale the years of experience by subtarcting the minimum from every row. */
select * from employees.departments;
select * from employees.salaries;
select * from employees.dept_emp;
select * from employees.dept_manager;
select * from employees.employees;
select * from employees.titles;

use bayes_820;

		/* Create temporary table that finds the total number of years a current employ has been working at the company.
		subtract minimum years from total years(17).  Group by years. */
create temporary table years1
select (substring(dept_emp.to_date, 1,4) - 7980 -17) - substring(dept_emp.from_date,1,4) as years_with_company, avg(salaries.salary) as avg_salary
from employees.dept_emp
join employees.salaries using(emp_no)
where dept_emp.to_date = '9999-01-01' and salaries.to_date = '9999-01-01'
group by years_with_company;

		-- Alter table to add columns for avg of all salaries and std dev of all salaires
alter table years1 add column avg_tot int;
alter table years1 add column std_dev int;

select * from years1;

		-- Update table with avg of all salaries
update years1
set avg_tot = 72012.2359;

		-- Update table with std dev of all salaries
update years1
set std_dev = 17309.95933634675;

		-- Use temporary table to calculate z_scores of years 0 -17.
select years_with_company, ((avg_salary - avg_tot) / std_dev) as z_score
from years1;