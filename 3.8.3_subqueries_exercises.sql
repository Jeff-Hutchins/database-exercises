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
	(select employees.first_name, employees.last_name, titles.title
	from employees
	join titles on employees.emp_no = titles.emp_no	
	where employees.first_name = 'Aamod');
	
-- How many people in the employees table are no longer working for the company?
select * from employees;
select * from dept_emp;

select employees.emp_no
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
where dept_emp.to_date not in ('9999-01-01');


-- Find all the current department managers that are female
-- Find department managers, then which are female
select * from dept_manager;
select * from employees;

select employees.first_name, employees.last_name, employees.gender
from employees
where employees.emp_no in
	(select emp_no
	from dept_manager
	where to_date = '9999-01-01')
having employees.gender = 'F';
