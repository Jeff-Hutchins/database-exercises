-- 3.11_more_exercises.sql

-- How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

use employees;

select * from employees.departments;
select * from employees.salaries;
select * from employees.dept_emp;
select * from employees.dept_manager;
select * from employees.employees;
select * from employees.titles;

	-- Avg salary by department name.
create temporary table avg_dept_salary2 (id INT UNSIGNED NOT NULL AUTO_INCREMENT, primary key(id))
SELECT dept_name, avg(salaries.salary) as s 
FROM employees.departments
JOIN employees.dept_emp USING(dept_no)
JOIN employees.salaries USING(emp_no)
join employees.employees USING(emp_no)
where dept_emp.to_date = '9999-01-01'
group by dept_name;

	-- Salary of each current department manager
create temporary table current_man_sal4 (id INT UNSIGNED NOT NULL AUTO_INCREMENT, primary key(id))
select departments.dept_name as department_name, concat(employees.first_name,' ',employees.last_name)as Name, salaries.salary as salary
from employees.departments
join employees.dept_manager
on dept_manager.dept_no = departments.dept_no
join employees.employees
on employees.emp_no = dept_manager.emp_no
join employees.salaries
on salaries.emp_no = employees.emp_no
where salaries.to_date = '9999-01-01' and dept_manager.to_date = '9999-01-01'
order by department_name;

select * from avg_dept_salary2;
select * from current_man_sal4;

use bayes820;

select Name, salary - s
from current_man_sal4
join avg_dept_salary2 on current_man_sal4.id = avg_dept_salary2.id;