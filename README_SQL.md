-- Day 1; SQL

show databases;

-- mysql.user means use the mysql database and read from the user table
select * from mysql.user;

-- the user and host columns from the user table
SELECT user, host FROM mysql.user;

-- select all columns from the help_topic table on the mysql databse
SELECT * FROM mysql.help_topic;

-- select only the help_topic_id, help_category_id, and url columns from help_topic table on mysql
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;

-- Day 2; SQL - Clauses

use sakila;

SELECT * FROM film;

SELECT * FROM film WHERE rating LIKE 'PG%';

SELECT * FROM film WHERE replacement_cost BETWEEN 18.99 AND 20.99;

SELECT DISTINCT release_year,rating FROM film;

SELECT DISTINCT title,rental_rate BETWEEN 299 AND 3.99 FROM film;

SELECT * FROM payment;

SELECT * FROM payment WHERE (rental_id>1000 AND staff_id=1) OR amount<5.99;

SELECT * FROM customer;

-- Use 'IN' function to shorten the code
SELECT * FROM customer WHERE first_name IN ('BARBARA','JOAQUIN','SANDRA');
SELECT * FROM customer WHERE first_name='BARBARA' OR first_name='JOAQUIN' OR first_name='SANDRA';


-- Day 2; MySQL functions

use sakila;

SELECT * FROM actor;
-- We're eventually going to be having python scripts that use SQL to pull information for databases.
-- SQL functions are vectorized, whereas python would need loops to do the same.
-- The LIKE function modifies the WHERE clause
SELECT concat(address, '\n ',district) as full_address from address;

SELECT concat('Hello',' ', 'World');

SELECT concat(address, ', ',district) as full_address 
FROM address
WHERE district not like '%berta';

SELECT sin(`actor_id`)
from actor;

SELECT cos(actor_id)
from actor;

SELECT tan(actor_id)
from actor;

SELECT count(*)
from actor;

use employees;

SELECT count(*)
FROM salaries
WHERE salary > 63000
AND to_date > now();

SELECT concat(first_name, ', ', last_name)
REGEXP '^a' as full_name
from employees;

SELECT concat(first_name,', ',last_name) as full_name
from employees;

SELECT SUBSTR(concat(first_name,', ',last_name), -4, 4) as full_name
from employees;

SELECT upper(name)
from fruits;

SELECT concat(upper(substring(name, 1, 1)),
substring(name, 2))
from fruits;

SELECT replace(name, 'cant', 'ant')
FROM fruits;

-- Day 2; SQL - Group by

SELECT DISTINCT first_name
from employees;

SELECT concat(first_name,' ',last_name) as full_name
from employees
group by full_name;  -- group by does two jobs, groups by distinct names(pulls out duplicates) and orders.

select count(*)
from employees;

select count(*)
from employees
where first_name NOT LIKE '%a%';

select concat(first_name, ' ',last_name) as full_name, count(*)
from employees
group by full_name DESC
ORDER BY count(*) DESC;

-- ORDER OF OPERATIONS FOR SQL QUERIES

-- SELECT columns
-- FROM table
-- JOINs
-- WHEREs
-- GROUP Bys
-- HAVING
-- ORDER Bys
-- LIMIT
-- Offset

-- Day 3; SQL
use sakila;
show create table rental;

use employees;

show create table employees;
show create table departments;
show create table dept_emp;
show create table dept_manager;
show create table salaries;
show create table titles;

CREATE TABLE roles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  role_id INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('author');
INSERT INTO roles (name) VALUES ('reviewer');
INSERT INTO roles (name) VALUES ('commenter');

INSERT INTO users (name, email, role_id) VALUES
('bob', 'bob@example.com', 1),
('joe', 'joe@example.com', 2),
('sally', 'sally@example.com', 3),
('adam', 'adam@example.com', 3),
('jane', 'jane@example.com', null),
('mike', 'mike@example.com', null);

use bayes_820; 

select * from users;
select * from roles;

SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

use employees;

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

use sakila;

select distinct
f.film_id,
f.title
from payment as p
join rental as r
on(p.rental_id=r.rental_id)
join inventory as i
on (r.inventory_id=i.inventory_id)
join film as f
on (i.film_id=f.film_id);

-- Day 4; SQL creating tables
use bayes_820;

create temporary table employee_salary as
	select first_name, last_name, salary
	from employees.employees
	join employees.salaries using(emp_no);

create temporary table favorite_actors
	select first_name
	from sakila.actors
	where first_name like '%ryan'
	
select * from employee_salary;
use bayes_820;
-- simple example of temporary table(for permanent tables, remove the temporary keyword)
create temporary table captains (
	name VARCHAR(256) not null,
	ship VARCHAR(256) not null
);
-- How to add new records to a table
insert into captains (name, ship) values ("Captain Ahab", "Pequad");

insert into captains (name, ship) values
	("Jean Luc Piccard", "USS Starship Enterprise NCC1701D"),
	("James Tiberius Kirk", "USS Starship Enterprise NCC1701A");

select * from captains;
-- USING THE SELECT TO DOUBLE CHECK WHAT YOURE GOING TO DELETE
-- If you ever need to delete a row or rows, create the select statement first.
delete from captains where name = "Captain Ahab";

create temporary table fruits (
	id int unsigned not null auto_increment,
	name varchar(256) not null,
	primary key(id)
);

insert into fruits (name) values ('Mango');
insert into fruits (name) values ('Kiwi');

insert into fruits (name) values
	('tangerine'),
	('Gala Apple'),
	('Banana');
	
select * from fruits;














-- Need to track the quantity of the fruits
ALTER TABLE fruits add quantity int unsigned;

alter table fruits drop column id;

select * from fruits;

-- SYNTAX for updating an entire column
update fruits
set quantity = 10;

-- SYNTAX for updating a specific row's column value
update fruits
set quantity = quantity * 10
where name = 'Kiwi';

-- change gala apple to red apple(if you dont have a 'where' clause you will change the entire column)
update fruits
set name = 'Red Apple'
where name = 'Gala Apple';