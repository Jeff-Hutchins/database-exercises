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

-- CLAUSES

-- SELECT STATEMENTS
	-- a. Select all columns from the actor table.
	select * from actor;
	
	-- b. Select only the last_name column from the actor table
	select last_name from actor;
	
	-- c. Select only the following columns from the film table
	select actor_id, first_name, last_update
	from actor;
	
-- DISTINCT OPERATOR
	-- a. Select all distinct (different) last names from the actor table
	select distinct last_name
	from actor;
	
	-- b. Select all distinct (different) postal codes from the address table
	select distinct postal_code
	from address;
	
	-- c. Select all distinct (different) ratings from the film table
	select distinct rating
	from film;
	
-- 3. WHERE clause

	-- a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
	select title, description, rating, length
	from film
	where length >179;
	

	-- b. Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
	select payment_id, amount, payment_date
	from payment
	where payment_date > '2005-05-27';
	
	
	-- c. Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
	select payment_id, amount, payment_date 
	from payment
	where payment_date like '2005-05-27%';


	-- .d Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
	select *
	from customer
	where last_name like 'S%' and first_name like '%N';


	-- .e Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
	select *
	from customer
	where last_name like 'M%' or active = 0;
	

	-- .f Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
	select *
	from category
	where category_id > 4 and name like 'C%' or name like 'S%' or name like 'T%';
	

	-- .g Select all columns minus the password column from the staff table for rows that contain a password.
	create temporary table staff
	select *
	from sakila.staff
	where password is not NULL;
	
	alter table staff drop column password;
	
	select * from staff;

	-- .h Select all columns minus the password column from the staff table for rows that do not contain a password.
	create temporary table staff2
	select *
	from sakila.staff
	where password is NULL;
	
	alter table staff2 drop column password;
	
	select * from staff2;

-- 4. IN OPERATOR

	-- a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
	select phone, district
	from address
	where district in ('California', 'England', 'Taipei', 'West Java');
	
	
	-- b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN 	operator and the DATE function, instead of the AND operator as in previous exercises.)
	select payment_id, amount, payment_date
	from payment
	where payment_date like '2005-05-25%' or payment_date like '2005-05-27%' or payment_date like '2005-05-29%';
	
	
	-- c. Select all columns from the film table for films rated G, PG-13 or NC-17.
	select *
	from film
	where rating in ('G', 'PG-13','NC-17');
	

-- 5. BETWEEN operator

	-- a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
	select *
	from payment
	where payment_date between '2005-05-25 00:00:00' and '2005-05-26 23:59:59';
	
	
	-- b. Select the following columns from the film table for films where the length of the description is between 100 and 120.
	-- Hint: total_rental_cost = rental_duration * rental_rate
	
	select *
	from film
	where length between 100 and 120;
	
-- 6. LIKE operator

	-- a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".
	select *
	from film
	where description like 'A Thoughtful%';
	
	
	-- b. Select the following columns from the film table for rows where the description ends with the word "Boat".
	select *
	from film
	where description like '%Boat';
	
	
	-- c. Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
	select *
	from film
	where description like '%Database%' and length > 180;
	
-- 7. LIMIT Operator

	-- a. Select all columns from the payment table and only include the first 20 rows.
	select *
	from payment
	limit 20;
	
	-- b. Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-	based index in the result set is between 1000-2000.
	select payment_id, payment_date, amount
	from payment
	where payment_id between 1000 and 2000 and amount > 5;
	
	
	-- c. Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
	select *
	from customer
	limit 100 offset 100;
	
-- 8. ORDER BY statement

	-- a. Select all columns from the film table and order rows by the length field in ascending order.
	select *
	from film
	order by length ASC;
	
	
	-- b. Select all distinct ratings from the film table ordered by rating in descending order.
	select distinct rating
	from film
	order by rating DESC;
	
	-- c. Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
	select payment_date, amount
	from payment
	order by amount DESC;
	
	-- d. Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes 	footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
	select title, description, special_features, length, rental_duration
	from film
	where special_features like '%Behind the Scenes%' and length < 120 and rental_duration between 5 and 7
	order by length DESC
	limit 10;
	
	
-- 9. JOINs

	-- a. Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the 		last_name column in each table. (i.e. customer.last_name = actor.last_name)
	
	-- Label customer first_name/last_name columns as customer_first_name/customer_last_name
	
	/*Label actor first_name/last_name columns in a similar fashion.
	returns correct number of records: 599 */
	
	select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as 		 actor_last_name
	from customer
	left join actor on customer.last_name = actor.last_name;	
	
	
	-- b. Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on 	the last_name column in each table. (i.e. customer.last_name = actor.last_name)
	
		-- returns correct number of records: 200
		
		
	select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as 		 actor_last_name
	from customer
	right join actor on customer.last_name = actor.last_name;	
	
	-- c Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the 	last_name column in each table. (i.e. customer.last_name = actor.last_name)
	
	-- returns correct number of records: 43
	
	select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as 		 actor_last_name
	from customer
	join actor on customer.last_name = actor.last_name;	

	-- d. Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
	
	-- Returns correct records: 600

	select city, country
 	from city
	left join country on city.country_id = country.country_id;

	-- e. Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the 	"language" column.
	
	-- Label the language.name column as "language"
	-- Returns 1000 rows
	
	select title, description, release_year, language.name as language
	from film
	left join language on language.language_id = film.language_id;
	
	-- f. Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
	
	-- returns correct number of rows: 2
	select * from address;
	select * from staff;
	select * from city;
	
	select first_name, last_name, address, address2, city, district, postal_code
	from staff
	left join address on address.address_id = staff.address_id
	left join city on city.city_id = address.city_id;

-- 1. What is the average replacement cost of a film?  Does this change depending on the rating of the film.
-- ANSWER = YES, the cost changes, but barely.

select avg(replacement_cost)
from film;

select avg(replacement_cost), rating
from film
group by rating;

-- 2. How many different films of each genre are in the database?
select * from film;
select * from category;
select * from film_category;

select category.name, count(film.film_id)
from film
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
group by category.category_id;
	
-- 3. What are the 5 frequently rented films?

select * from film;
select * from rental;
select * from inventory;
select * from payment;

select title, count(rental.inventory_id) as total
from film
join inventory on inventory.film_id = film.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by title
order by total desc
limit 5;

	
	
