List of all tables in the "employees" database:

current_dept_emp
departments
dept_emp
dept_emp_latest_date
dept_manager
employees
salaries
titles

describe employees;

5. Data types present on the "employees table";

birth_date	date	NO		NULL	
first_name	varchar(14)	NO		NULL	
last_name	varchar(16)	NO		NULL	
gender	enum('M','F')	NO		NULL	
hire_date	date	NO		NULL	

6. Tables that contain numeric type column:
current_dept_emp
dept_emp
dept_emp_latest_date
dept_manager
employees
salaries
titles

7. Tables that contain a string type:
current_dept_emp
departments
diept_emp
dept_manager
employees
titles

8. Tables that contain a date type:
All except departments

9. Relationship between employees and departments tables?
No direct relationship.  dept_emp table shows what employee number and id number match.

10. Code that created the dept manager table:
CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



SQL Code Used to query:

use employees;

select * from employees;

show tables;

describe current_dept_emp;

describe departments;

describe dept_emp;

describe dept_emp_latest_date;

describe dept_manager;

describe employees;

describe salaries;

describe titles;