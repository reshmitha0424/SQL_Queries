USE SAKILA;
SHOW TABLES;

-- EASY
-- 1. List all film titles and their rental rates.
select title, rental_rate from film;

-- 2. Show all customers’ first name, last name, and email.
select first_name, last_name, email from customer;

-- 3. List all films with a rental rate greater than 3.
select title, rental_rate from film
where rental_rate>3;

-- 4. Show all films released in the year 2006.
select title, release_year from film
where release_year = 2006;

-- 5. List the distinct ratings available.
select distinct rating from film;

-- 6. Show the top 10 longest films.
select title, length from film
order by length desc
limit 10;

-- 7. List all customers whose first name starts with the letter ‘A’.
select * from customer
where first_name like "A%";

-- 8. Show all films whose length is between 90 and 120 minutes.
select title, length from film
where length between 90 and 120
order by length;

-- MEDIUM
-- 9. Show each rating and the number of films under that rating.
select rating, count(title) as num_films from film
group by rating
order by num_films;

-- 10. List customers along with the total amount they have paid.
select customer_id, first_name, last_name, sum(amount) as total_amt from payment
join customer
using (customer_id)
group by customer_id
order by total_amt;

-- 11. Show the total number of rentals made by each customer.
select customer_id, count(rental_id) as total_rentals from rental
group by customer_id
order by total_rentals;

-- 12. List all films along with their category name.
select title, c.name as category_name from film_category
join film
using (film_id)
join category as c
using (category_id);

-- 13. Show each rental with the customer name and rental date.
select rental_id, first_name, last_name, rental_date from rental
join customer
using (customer_id);

-- 14. Find the average rental rate for each rating.
select rating, avg(rental_rate) as avg_rental_rate from film
group by rating
order by avg_rental_rate;

-- 15. List all categories that have more than 50 films.
select name, count(film_id) as num_films from film_category
join category
using (category_id)
group by name
order by num_films;

-- 16. Show the top 5 customers who have paid the highest total amount.
select customer_id, first_name, last_name, sum(amount) as total_amt from payment
join customer
using (customer_id)
group by customer_id
order by total_amt desc
limit 5;

-- 17. List all films that belong to the category “Action”.
select title, name from film_category
join category
using (category_id)
join film
using (film_id)
where name="Action";

-- HARD
-- 18. List all films whose rental rate is greater than the average rental rate.
select title, rental_rate from film
where rental_rate > (select avg(rental_rate) from film)
order by rental_rate;

-- 19. Show customers who have made more rentals than the average number of rentals per customer.
select customer_id, count(rental_id) as cnt_rentals from rental
group by customer_id
having cnt_rentals > (
select customer_id, avg(rental_id) as avg_rental_id from rental
group by customer_id);








































