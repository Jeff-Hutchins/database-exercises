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

	-- Join both temporary tables and subtract the avg managers salary per department from the current managers salaries by department.
select Name, salary - s
from current_man_sal4
join avg_dept_salary2 on current_man_sal4.id = avg_dept_salary2.id;

-- USE THE WORLD DATABSE FOR THE QUESTIONS BELOW

-- What languages are spoken in Santa Monica?

select * from city;
select * from country;
select * from countrylanguage;

	-- Find CountryCode for Santa Monica
select Name, CountryCode
from city
where Name = 'Santa Monica';
	-- Select langauges and % for CountryCode USA
select language, percentage
from countrylanguage
where CountryCode = 'USA'
order by percentage;

-- How many different coutries are in each region?

select region, count(name)
from country
group by region
order by count(name);
	
-- What is the population for each region?

select region, SUM(population)
from country
group by region;

-- Whwat is the population for each continent?

select continent, sum(population)
from country
group by continent
order by sum(population) DESC;

-- What is the average life expectancy globally?

select avg(lifeexpectancy)
from country;

-- What is the average life expectancy for each region, each continent?  Sort results from shortest to longest.

select continent, avg(lifeexpectancy) as life_expectancy
from country
group by continent
order by life_expectancy;

select region, avg(lifeexpectancy) as life_expectancy
from country
group by region
order by life_expectancy;

-- BONUS
-- Find all the countries whose local name is different from the official name
-- How many countries have a life expectancy less than x?
-- What state is city x located in?
-- What region of the world is city x located in?
-- What country (use the human readable name) city x located in?
-- What is the life expectancy in city x?

-- USE SAKILA DATABASE FOR QUESTIONS BELOW

-- 1. Display the first and last namese in all lowercase of all the actors

select * from actor;

select lower(concat(first_name,' ', last_name)) as Actors
from actor;

-- 2. Select id number and actor name from just the first names.

select concat(actor_id,' ',first_name,' ', last_name)
from actor
where first_name = 'NICK';

-- 3. Find all actors whose last name contain the letters "gen"

select concat(actor_id,' ',first_name,' ', last_name)
from actor
where last_name like '%GEN%';

-- 4. Find all actors whose lastr names contain the letters "li".  This time, order the rows by last name and first name, in that order.

select first_name, last_name
from actor
where last_name like '%LI%'
order by last_name, first_name;

-- 5. Using IN, display the country_id and country columns for the following countries:
-- Afghanistan, Bangladesh, and China:

select * from country;

select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 6. List the last names of all the acgtors, as well as how many actors have that last name.

select * from actor;

select last_name, count(last_name)
from actor
group by last_name;

-- 7. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors.

select last_name, count(last_name) as repeated
from actor
group by last_name
order by repeated DESC
limit 55;

-- 8. You cannot locate the schema of the address table.  Which query would you use to re-create it?

show create table address;

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
select * from staff;
select * from address;

select first_name, last_name, address
from staff
join address on staff.address_id = address.address_id;

-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.

select * from staff;
select * from payment;

select first_name, last_name, sum(amount)
from staff
join payment on staff.staff_id = payment.staff_id
where payment.payment_date like '2005-08%'
group by first_name, last_name;

-- 11. List each film and the numnber of actors who are listed for that film.

select * from film;
select * from actor;
select * from film_actor;

select title, count(actor.actor_id) as number_of_actors
from film
join film_actor on film.film_id = film_actor.film_id
join actor on actor.actor_id = film_actor.actor_id
group by title;

-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
-- ANSWER = 6
select * from inventory;
select * from film;

select count(*)
from inventory
where film_id =
	(select film_id
	from film
	where title = 'Hunchback Impossible');
	
-- 13. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

select * from film;
select * from language;

select title
from film
where title like 'K%' or title like 'Q%' and title in
	(select title
	from film
	where language_id = 1);
	
-- 14. Use subqueries to display all actors who appear in the film Alone Trip.

select * from actor;
select * from film_actor;
select * from film;

select first_name, last_name
from actor
where actor_id in
	(select actor_id
	from film_actor
	where film_id =
		(select film_id
		from film
		where title = 'Alone Trip'));
		
-- 15. Get names and email addresses of all Canadian customers.
select * from address;
select * from city;
select * from customer;
select * from country;

select first_name, last_name, email
from customer
where address_id in
	(select address_id
	from address
	where city_id in
		(select city_id
		from city
		where country_id =
			(select country_id
			from country
			where country = 'Canada')));

-- 16. Identify all movies categorized as family films.

select * from film;
select * from film_category;
select * from category;

select title
from film
where film_id in 	
	(select film_id
	from film_category
	where category_id =
		(select category_id
		from category
		where name = 'Family'));
		
-- 17. Write a query to display how much business, in dollars, each store brought in

select * from store;
select * from staff;
select * from payment;

select staff_id, sum(amount)
from payment
where staff_id in
	(select staff_id
	from staff
	where store_id in
		(select store_id
		from store))
group by staff_id;

-- 18. Write a query to display for each store its store ID, city, and country.

select * from store;
select * from address;
select * from city;
select * from country;

select store_id, city, country
from store
join address on address.address_id = store.address_id
join city on city.city_id = address.city_id
join country on country.country_id = city.country_id;

-- 19. List the top five genres in gross revenue in descending order

select * from category;
select * from film_category;
select * from inventory;
select * from payment;
select * from rental;

select category.name, sum(payment.amount)
from rental
join payment on rental.rental_id = payment.rental_id
join inventory on rental.inventory_id = inventory.inventory_id
join film_category on inventory.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name
order by sum(payment.amount) DESC
limit 5;
