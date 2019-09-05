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

 




