-- ----------------------------------------------------------------------------------------------------------------------
-- Find all films rated 'PG-13' with a rental rate greater than 2.99.
select * from film
where rating like "PG-13" and rental_rate>2.99;
-- = would be more appropriate than LIKE here. LIKE is meant for pattern matching 
-- LIKE 'PG-13' (no % or _) has no pattern to match — it just checks if the string is exactly 'PG-13', which is exactly what = does.

-- ----------------------------------------------FUNDAMENTALS-----------------------------------------------------------
-- Find all films that are rated either 'G' or 'PG'.
select * from film
where rating = "G" or rating = "PG";

SELECT * FROM film
WHERE rating IN ('G', 'PG');
-- The IN version is preferred when checking whether a column matches one of several values because it's shorter and easier to read.

-- select * from film
-- where rating = "G" or "PG";

-- it is interpreted as WHERE (rating = 'G') OR ('PG')
-- The second part ('PG') is just a string, not a condition like rating = 'PG'.
-- In SQLite, 'PG' is treated as FALSE, so the query behaves like: WHERE rating = 'G'
-- ----------------------------------------------------------------------------------------------------------------------
-- Find all rentals that happened in May 2005.
select * from rental
where rental_date between '2005-05-01' AND '2005-05-31 23:59:59';
-- BETWEEN is inclusive on both ends in SQL. So this includes everything from 2005-05-01 00:00:00 up through 2005-05-31 23:59:59.

select * from rental
where year(rental_date)=2005 and month(rental_date)=5;

select * from rental
where rental_date like "2005-05%";
-- MySQL converts the datetime to a string like '2005-05-14 21:30:00', so LIKE '2005-05%' does match all May 2005 rentals.
-- Using LIKE on dates works but isn't a great habit — it's slower (can't use indexes efficiently) and less clear to read. 
-- The more standard way is with BETWEEN or explicit date functions

-- ---------------------------------------------- JOINS -------------------------------------------------------
-- Find all customers who live in the same city as another customer — a self join on the customer/address/city chain, 
select a.first_name, a.last_name, a.city, b.first_name, b.last_name
from (
	select customer_id, first_name, last_name, city, city_id from customer
	join address using (address_id)
	join city using (city_id)) as a
join (
	select customer_id, first_name, last_name, city, city_id from customer
	join address using (address_id)
	join city using (city_id)) as b
on a.city_id = b.city_id AND a.customer_id != b.customer_id;

-- a normal join can't compare "customer A" to "customer B" — a table only has itself, 
-- so how do you compare rows within the same table to each other? 
-- That's what a self join solves: you pretend the table is two separate copies, give them different names, and compare rows between the two copies.

-- ----------------------------------------------------------------------------------------------------------------------
