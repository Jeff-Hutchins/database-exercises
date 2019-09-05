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

-- Which department has the highest average salary? Anytime you use an aggregate function you need a "group by"
select departments.dept_name as dept_name, avg(salaries.salary) as average_salary
from departments
join dept_emp
on departments.dept_no = dept_emp.dept_no
join salaries
on dept_emp.emp_no = salaries.emp_no
where salaries.to_date = '9999-01-01'
group by departments.dept_name
-- having average_salary > 82000
order by dept_name DESC
limit 1;

-- Who is the highest paid employee in the Marketing department?
select employees.first_name, employees.last_name
from employees
join dept_emp
on dept_emp.emp_no = employees.emp_no
join departments
on departments.dept_no = dept_emp.dept_no
join salaries
on salaries.emp_no = employees.emp_no
where salaries.to_date = '9999-01-01' and dept_name = 'Marketing'
group by employees.first_name, employees.last_name, salaries.salary, departments.dept_name
order by salary DESC
limit 1;

-- Which current department manager has the highest salary?
select employees.first_name, employees.last_name, salaries.salary, departments.dept_name as dept_name
from departments
join dept_manager
on dept_manager.dept_no = departments.dept_no
join employees
on employees.emp_no = dept_manager.emp_no
join salaries
on salaries.emp_no = employees.emp_no
where salaries.to_date = '9999-01-01' and dept_manager.to_date = '9999-01-01'
order by salary desc
limit 1;

-- BONUS
-- Find the names of all current employees, their department name, and their current manager's name.
select concat(employees.first_name,' ',employees.last_name) as Employee_Name, departments.dept_name as Department_Name, concat(employees.first_name,' ',employees.last_name) as Manager_Name
from employees
join dept_emp
on dept_emp.emp_no = employees.emp_no
join departments
on departments.dept_no = dept_emp.dept_no
join dept_manager
on departments.dept_no = dept_manager.dept_no
where dept_manager.to_date = '9999-01-01'
group by employees.first_name, employees.last_name, Department_Name, Manager_Name
order by Department_Name;
