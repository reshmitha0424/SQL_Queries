use sakila;
show tables;

-- ---------- DAY 1 --------------

-- 1. Write a query to display all columns from the film table.
select * from film;

-- 2. Display the title, rating, and rental_rate from the film table.
select title, rating, rental_rate from film;

-- 3. Display title and rating of films that are rated 'PG'.
select title, rating from film
where rating = 'PG';
-- In MySQL, "PG" works, but best practice is single quotes:

-- 4. Display title and rental_rate of all films, ordered by rental_rate in descending order.
select title, rental_rate from film
order by rental_rate desc;

-- 5. Display the top 5 most expensive films based on rental_rate.
select title, rental_rate from film
order by rental_rate desc
limit 5;

-- 6. Find the total number of films in the film table.
select count(*) as total_films from film;

-- 7. Find the number of films in each rating category.
select rating, count(*) as num_films from film
group by rating;
-- COUNT(*) is preferred over COUNT(title) unless you specifically need to ignore NULLs.

-- 8. Find the rating categories that have more than 200 films.
select rating, count(*) as num_films from film
group by rating
having num_films>200;

-- 9. Find the films whose rental_rate is higher than the average rental rate of all films.
select rental_rate, title from film
where rental_rate > (select avg(rental_rate) from film)
order by rental_rate;

-- 10. Display the title of films and the name of their category.
select title, name from film
join film_category
using (film_id)
join category
using (category_id);

-- 11. Find the number of films in each category. Display category_name, num_films;
select name as category_name, count(*) as num_films from film
join film_category
using (film_id)
join category
using (category_id)
group by name;

-- 12.a. Find the category that has the maximum number of films - using group by and limit
select name as category_name, count(*) as num_films from film
join film_category
using (film_id)
join category
using (category_id)
group by name
order by num_films desc
limit 1;

-- 12.a. Find the category that has the maximum number of films - using subquery 
select name as category_name, count(*) as num_films from film
join film_category
using (film_id)
join category
using (category_id)
group by name
having count(*) = (
					select max(film_count) from (
												select count(*) as film_count from film
                                                join film_category
                                                using (film_id)
                                                join category
                                                using (category_id)
                                                group by category
                                                ) as sub
					);

				
-- ---------- DAY 2 --------------
-- 13. Find the top 5 customers who have made the highest total payment 
select customer_id, first_name, last_name, sum(amount) as total_amt from customer
join payment
using (customer_id)
group by customer_id, first_name, last_name
order by sum(amount) desc
limit 5;

-- 14. Find customers who have made more than 30 payments.
select customer_id, first_name, last_name, count(payment_id) as num_payments from customer
join payment
using (customer_id)
group by customer_id, first_name, last_name
having count(payment_id) > 30
order by num_payments;

-- 15. Find the film that have been rented the most times.
select film_id, title, count(rental_id) as times_rented from film
join inventory
using (film_id)
join rental
using (inventory_id)
group by film_id, title
order by count(rental_id) desc
limit 1;

-- 16. Find the film(s) that have been rented the most times (can be more than 1 film) - so use subquery
-- step 1: count rentals per film
select film_id, title, count(rental_id) as times_rented 
from film
join inventory using (film_id)
join rental using (inventory_id)
group by film_id, title;
-- step 2: from that, find the max times_rented
select max(times_rented) from (
								select count(rental_id) as times_rented 
								from film
								join inventory using (film_id)
								join rental using (inventory_id)
								group by film_id, title) as sub;
--  step 3: modify step 1 to consider only the ones with max(times_rented)
select film_id, title, count(rental_id) as times_rented 
from film
join inventory using (film_id)
join rental using (inventory_id)
group by film_id, title
having count(rental_id) = (
							select max(times_rented) from (
															select count(rental_id) as times_rented 
															from film
															join inventory using (film_id)
															join rental using (inventory_id)
															group by film_id, title) as sub
                                                            );

-- 17. Find the top 3 categories that generated the highest total revenue.
select name as category_name, sum(amount) as total_revenue from film
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
join film_category using (film_id)
join category using (category_id)
group by category_name
order by total_revenue desc
limit 3;

-- 18. Find the month-wise total revenue.
select year(payment_date) as year, month(payment_date) as month, sum(amount) as total_revenue from payment
group by year, month
order by year, month;

-- 19. Find the customer who generated the highest revenue in a single month.
select customer_id, first_name, last_name, year(payment_date), month(payment_date), sum(amount) from customer
join payment using (customer_id)
group by customer_id, first_name, last_name, year(payment_date), month(payment_date)
order by sum(amount) desc
limit 1;

-- 20. Find the running total revenue over time (cumulative revenue).
select payment_date, amount, sum(amount) over(order by payment_date) as running_totals_overall from payment
order by payment_date;

-- 21.Find the running total revenue per customer (cumulative spend for each customer over time).
select customer_id, payment_date, amount,
sum(amount) over(partition by customer_id order by payment_date) as running_totals_per_cust from payment
order by customer_id, payment_date;

