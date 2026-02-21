-- BASIC QUERIES

-- (1) List the names of all films that are rated 'PG'.
select * from sakila.film; -- printing the database
select title from sakila.film 
where rating = 'PG';

-- (2) Find the first and last names of customers living in California.
select * from sakila.customer; -- printing the database
select * from sakila.address; -- printing the database
select first_name, last_name 
from sakila.customer
join sakila.address 
on sakila.address.address_id = sakila.customer.address_id
where sakila.address.district = 'California';

-- (3) Show all rental dates for the customer with the email MARY.SMITH@sakilacustomer.org.
select * from sakila.customer; -- printing the database
select * from sakila.rental; -- printing the database
select rental_date from sakila.rental
join sakila.customer
on sakila.customer.customer_id=sakila.rental.customer_id
where sakila.customer.email = 'MARY.SMITH@sakilacustomer.org';

-- -------------------------
-- JOINS

-- (1) List all films along with their language names.
select * from sakila.film;
select * from sakila.language;
select sakila.film.title, sakila.language.name from sakila.film 
join sakila.language
on sakila.language.language_id = sakila.film.language_id;

-- (2) Show the names of actors who acted in the film "ACADEMY DINOSAUR".
select * from sakila.actor;
select * from sakila.film;
select * from sakila.film_actor;
select sakila.actor.first_name, sakila.actor.last_name 
from sakila.actor
join sakila.film_actor
on sakila.actor.actor_id = sakila.film_actor.actor_id -- actor & film_actor tables have actor_id as common column
join sakila.film
on sakila.film.film_id=sakila.film_actor.film_id -- film and film_actor tables have film_id as common column
where sakila.film.title='ACADEMY DINOSAUR';

-- (3) Find the address and city of each customer
select * from sakila.city;
select * from sakila.address;
select * from sakila.customer;
select sakila.customer.first_name, sakila.customer.last_name, sakila.address.address, sakila.city.city
from sakila.city
join sakila.address
on sakila.city.city_id=sakila.address.city_id
join sakila.customer
on sakila.address.address_id=sakila.customer.address_id;

