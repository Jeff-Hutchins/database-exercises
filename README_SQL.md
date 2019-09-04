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
