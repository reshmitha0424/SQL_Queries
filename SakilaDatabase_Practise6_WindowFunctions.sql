-- Window Functions 

-- row_number
-- List the top 5 most rented movies with a row number for each movie based on rental count (most to least).
select film_id, title as film, count(rental_id) as rental_count, 
row_number() over(ORDER BY COUNT(rental_id) DESC) as row_num -- we used order by here because it should assign row num based on rental id, but not randomly
from sakila.rental
join sakila.inventory
using (inventory_id)
join sakila.film
using (film_id)
group by film_id
order by rental_count desc
limit 5;

-- Find the ranking of each movie by rental count using RANK() and DENSE_RANK(). What’s the difference?
select film_id, title as film, count(rental_id) as rental_count, 
rank() over(ORDER BY COUNT(rental_id) DESC) as rank_num,
dense_rank() over(ORDER BY COUNT(rental_id) DESC) as denserank_num
from sakila.rental
join sakila.inventory
using (inventory_id)
join sakila.film
using (film_id)
group by film_id
order by rental_count desc;

-- Divide all customers into 4 groups (NTILE(4)) based on their total amount spent.
select customer_id, total_spent,
ntile(4) over(order by total_spent) as spend_group
from (
	select customer_id, sum(amount) as total_spent
	from sakila.payment
	group by customer_id) as customer_totals
order by total_spent;


-- Simple Aggregates with OVER():
-- For each payment, show: the payment amount, the total payments made by that customer 
select payment_id, customer_id, amount, sum(amount) over(partition by customer_id) as customer_totals
from sakila.payment;

-- dividing into spending groups using ntile()
select customer_id, customer_totals, 
ntile(10) over(order by customer_totals) as spend_group
from (
	select payment_id, customer_id, amount, 
    sum(amount) over(partition by customer_id) as customer_totals
	from sakila.payment) as customer_totals
order by customer_totals;

-- For each customer, list their payments with a running total (cumulative sum) of the amounts they've paid.
select payment_id, customer_id, amount, 
sum(amount) over(partition by customer_id order by payment_id) as running_totals
from sakila.payment;




