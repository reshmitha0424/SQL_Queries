use sakila;
-- 1. List all films’ titles and rental rates, ordered from highest to lowest rental rate.
select title, rental_rate from film
order by rental_rate;

-- 2. Get all films with rating = 'PG-13' and length > 100 minutes.
select * from film
where rating = 'PG-13' and length > 100 ;

-- 3. Show each rating and how many films fall under that rating.
select rating, count(film_id) from film
group by rating;

-- 4. Find the top 5 customers (by customer_id) created most recently.
select * from customer
order by create_date desc
limit 5;

-- 5. For each store, find the total amount of payments made by customers of that store.
select store_id, sum(amount) as total_amount from customer as c
join payment as p
using (customer_id)
group by store_id;

-- 6. For each rating, find the average rental rate and average length of films. Only include ratings where the average length > 100.
select rating, avg(rental_rate), avg(length) from film
group by rating
having avg(length)>100;

-- 7. Get a list of all rentals, including: rental_id, rental_date, customer full name as customer_name (first + last), amount of the payment, 
select rental_id, rental_date, CONCAT(first_name, ' ', last_name) AS customer_name , amount 
from rental as r
join customer as c
using (customer_id)
join payment as p
using (rental_id);

-- 8. Find the top 5 customers by total amount they have paid.
select customer_id, concat(first_name, ' ', last_name) as customer_name, sum(amount) as total_amount from customer
join payment 
using (customer_id)
group by customer_id
order by total_amount desc
limit 5;


















