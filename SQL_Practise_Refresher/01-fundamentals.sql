-- ----------- JULY 2, 2026 ------------
USE sakila; -- sets sakila as the active database so queries know which schema's tables to look in.

-- 1. Get the first and last name of all customers who are currently active.
select first_name, last_name from customer
where active = 1;

-- 2. Find all films rated 'PG-13' with a rental rate greater than 2.99.
select * from film
where rating like "PG-13" and rental_rate>2.99;
-- = would be more appropriate than LIKE here. LIKE is meant for pattern matching 
-- LIKE 'PG-13' (no % or _) has no pattern to match — it just checks if the string is exactly 'PG-13', which is exactly what = does.

select * from film
where rating = "PG-13" and rental_rate>2.99;

-- 3. Find all films that are rated either 'G' or 'PG'.
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


-- 4. Find all films that are NOT rated 'R' or 'NC-17'.
SELECT * FROM film
WHERE rating NOT IN ('R', 'NC-17');

-- 5. Find all films whose title starts with the letter 'A'.
select * from film
where title like "A%";

-- 6. Find all films whose title contains the word 'LOVE' anywhere in it.
select * from film
where title like "%LOVE%";

-- 7. Find all films with a rating of 'G', 'PG', or 'PG-13' 
select * from film
where rating IN ("G", "PG", "PG-13");

-- 8. Find all films with a length between 90 and 120 minutes.
select * from film
where 120>length and length>90;

select * from film
where length between 90 and 120;

-- 9. Find all rentals that happened in May 2005.
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

-- 10. Find all customers who don't have an email on file.
select * from customer
where email is NULL;

-- 11. Get a list of all distinct film ratings that exist in the database.
select distinct rating from film;

-- 12. Find the 10 longest films with a rating of 'PG' or 'PG-13', sorted by length descending, and if two films have the same length, sort those alphabetically by title.
select * from film
where rating IN ('PG', 'PG-13')
order by length desc, title asc
limit 10;

-- 13. Find films whose description mentions "love", excluding films rated 'G', sorted by length descending — but exclude the 5 longest from your result.
select * from film
where description like "%love%" and rating != "G"
order by length desc
limit 100000 offset 5;

-- 14. Find active customers who have an address on file but no email, sorted alphabetically by last name.
select * from customer
where active =1 and address_id is not null and email is NULL 
order by last_name;