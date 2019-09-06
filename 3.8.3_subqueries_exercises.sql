-- 3.8.3_subqueries_exercises.sql

select * from departments;
select * from dept_manager;
select * from employees;
select * from titles;
select * from dept_emp;
select * from salaries;

-- 1992-12-28 hire date

-- Find all the employees with the same hire date as employee 101010 using sub-query.
select employees.emp_no, employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date in(
	select employees.hire_date
	from employees
	where employees.emp_no = 101010);
	
-- Find all the titles held by all employees with the first name Aamod.
select titles.title
from titles
where emp_no in	
	(select employees.emp_no
	from employees)
group by title;
	
select employees.first_name, employees.last_name, titles.title
from employees
join titles on employees.emp_no = titles.emp_no	
where employees.first_name = 'Aamod';
	
-- How many people in the employees table are no longer working for the company?
select dept_emp.emp_no, to_date
from dept_emp
where to_date not in ('9999-01-01') and dept_emp.emp_no in
	(select employees.emp_no
	from employees);

select employees.emp_no
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
where dept_emp.to_date not in ('9999-01-01');


-- Find all the current department managers that are female
select employees.first_name, employees.last_name, employees.gender
from employees
where employees.emp_no in
	(select emp_no
	from dept_manager
	where to_date = '9999-01-01')
having employees.gender = 'F';

-- Find all employees that currently have a higher than average salary.
select distinct employees.first_name, employees.last_name, salaries.salary
from employees
join salaries on employees.emp_no = salaries.emp_no
where salaries.to_date = '9999-01-01' and salaries.salary >
	(select avg(salaries.salary)
	from salaries);
	
-- How many current salaries are within 1 standard deviation of the highest salary?
select distinct employees.first_name, employees.last_name, salaries.salary
from employees
join salaries on employees.emp_no = salaries.emp_no
where salaries.to_date = '9999-01-01' and salaries.salary >
	(select max(salaries.salary) - std(salaries.salary)
	from salaries);
	
-- BONUS

-- Find all the department names that currently have female managers
select employees.gender
from employees
where employees.emp_no in
	(select 
	from dept_manager
	where to_date = '9999-01-01')
having employees.gender = 'F';