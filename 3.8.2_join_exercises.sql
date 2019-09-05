-- 3.8.2_join_exercises.sql

use join_example_db;

select * from users;
select * from roles;

select users.name as user_name, roles.name as role_name
from users
join roles on users.role_id = roles.id;

select users.name as user_name, roles.name as role_name
from users
left join roles on users.role_id = roles.id;

select users.name as user_name, roles.name as role_name
from users
right join roles on users.role_id = roles.id;

select count(users.name), roles.name as role_name
from users
left join roles on users.role_id = roles.id
group by role_name;

use employees;

select * from departments;
select * from dept_manager;
select * from employees;
select * from titles;
select * from dept_emp;
select * from salaries;

-- Write a query that shows each department along with the name of the current manager for that department.
select distinct departments.dept_name as department_name, concat(employees.first_name,' ',employees.last_name) as department_manager
from employees
join dept_manager
on dept_manager.emp_no = employees.emp_no
join departments
on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01'
order by department_name;

-- Find the name of all departments currently managed by women.
select distinct departments.dept_name as department_name, concat(employees.first_name,' ',employees.last_name) as department_manager
from employees
join dept_manager
on dept_manager.emp_no = employees.emp_no
join departments
on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01' and employees.gender = 'F'
order by department_name;

-- Find the current titles of employees currently working in the customer service department
select distinct titles.title, count(titles.title) as count
from titles
join dept_emp
on dept_emp.emp_no = titles.emp_no
join departments
on departments.dept_no = dept_emp.dept_no
where titles.to_date = '9999-01-01' and dept_emp.dept_no = 'd009'
group by title;

-- Find the current salary of all current managers;
select departments.dept_name as department_name, concat(employees.first_name,' ',employees.last_name)as Name, salaries.salary
from departments
join dept_manager
on dept_manager.dept_no = departments.dept_no
join employees
on employees.emp_no = dept_manager.emp_no
join salaries
on salaries.emp_no = employees.emp_no
where salaries.to_date = '9999-01-01' and dept_manager.to_date = '9999-01-01';


-- Find the number of employees in each department.
select departments.dept_no, departments.dept_name, count(employees.emp_no)
from departments
join dept_emp
on departments.dept_no = dept_emp.dept_no
join employees
on dept_emp.emp_no = employees.emp_no
where dept_emp.to_date = '9999-01-01'
group by departments.dept_name
order by dept_no;

-- Which department has the highest average salary?
select departments.dept_name as dept_name, avg(salaries.salary) as average_salary
from departments
join dept_emp
on departments.dept_no = dept_emp.dept_no
join salaries
on dept_emp.emp_no = salaries.emp_no
where salaries.to_date = '9999-01-01'
group by departments.dept_name
having average_salary > 82000
order by dept_name DESC
