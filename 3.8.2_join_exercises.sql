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

select distinct departments.dept_name as department_name, concat(employees.first_name,' ',employees.last_name) as department_manager
from employees
join dept_manager
on dept_manager.emp_no = employees.emp_no
join departments
on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01'
order by department_name;

select distinct departments.dept_name as department_name, concat(employees.first_name,' ',employees.last_name) as department_manager
from employees
join dept_manager
on dept_manager.emp_no = employees.emp_no
join departments
on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01' and employees.gender = 'F'
order by department_name;


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
-- departments, dept_emp, number of employees

select departments.dept_no, departments.dept_name, count(employees.emp_no)
from employees
join departments
on departments.dept_no = dept_emp.dept_no
join dept_emp
on dept_emp.emp_no = employees.emp_no
where dept_emp.to_date = '9999-01-01'
group by debt_emp.dept_no;

