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

-- --------------------------------------------------SUBQUERIES----------------------------------------------------
-- Find all customers whose total payments are above the overall average total-payment-per-customer (this needs a subquery in the FROM or WHERE — think about what the "average total per customer" means first).
select customer_id, sum(amount) as total_payment_per_customer from payment
group by customer_id
having sum(amount) > (
					select avg(total_payment_per_customer) from (
																select customer_id, sum(amount) as total_payment_per_customer from payment
																group by customer_id)as a
                                                                );

-- ----------------------------------------------------------------------------------------------------------------------
-- For each customer, find their most recent rental date (a subquery in SELECT, correlated to the outer customer row).
select customer_id, first_name, last_name, (select max(rental_date) from rental
											where rental.customer_id = customer.customer_id) as most_recent_rental
from customer;                                            
-- The inner subquery runs once per row of the outer customer table, not just once overall.
-- Each time it runs, customer.customer_id refers to whatever customer row the outer query is currently processing.
-- The subquery uses that specific customer_id to filter rental, then finds the MAX(rental_date) among just that customer's rentals.
-- This makes it "correlated" — the inner query depends on ("correlates with") the outer row, unlike a normal subquery that computes one fixed value used for every row.
-- Result: each customer gets their own personalized most_recent_rental value, calculated fresh for them.     

-- ----------------------------------------------------------------------------------------------------------------------
-- Find all films that have a longer length than the average length of films in their own category 
-- (this is a correlated subquery — the average must be recalculated per category, correlated to each outer row).
select * from film as f1
join film_category as fc1 on f1.film_id = fc1.film_id
where f1.length > (select avg(f2.length) 
				from film as f2
                join film_category as fc2 on f2.film_id = fc2.film_id
				where fc2.category_id = fc1.category_id);
-- We need two "copies" of the film+category info: f1/fc1 for the outer film we're checking, and f2/fc2 used only inside the subquery.
-- For each outer film (f1), the subquery recalculates the average length, but only using films from f2 that share the same category as f1 (fc2.category_id = fc1.category_id is the correlation link).
-- This means the "average" isn't one fixed number for the whole table — it's a different average depending on which category the current outer film belongs to.
-- The outer query then checks: is this film's length greater than the average length of its own category's films?
-- Just like Q6, the subquery reruns fresh for every outer row, each time using that row's category to filter what gets averaged.    
-- ----------------------------------------------------------------------------------------------------------------------

-- Find the second most expensive film by rental rate (without using LIMIT/OFFSET — think subqueries).
select * from film
where rental_rate = (select max(rental_rate) from film
					where rental_rate < (select max(rental_rate) from film));
-- Find the overall max rental_rate (that's the "most expensive")
-- Now look only at films where rental_rate is less than that max
-- Find the max rental_rate within that smaller group — that's the second most expensive
-- ----------------------------------------------------------------------------------------------------------------------
-- Find customers who have rented more films than the average number of rentals per customer.
-- average number of rentals per customer:
select avg(rental_count) from (select customer_id, count(rental_id) as rental_count from rental
								group by customer_id) as customer_rentals;
-- customers whose own rental count is above that average:
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id
HAVING rental_count > (select avg(rental_count) from (select customer_id, count(rental_id) as rental_count from rental
								group by customer_id) as customer_rentals);                                
-- ----------------------------------------------------------------------------------------------------------------------
-- Find all categories whose average film rental_rate is higher than the overall average rental_rate across all films (correlated-style: first get overall average as one subquery, then compare each category's own average against it — think about whether this needs GROUP BY + HAVING, or a correlated subquery, or both).
-- (1) the overall average rental_rate across all films:
select avg(rental_rate) as avg_rental_rate from film;
-- (2) Each category's own average rental_rate:
select category_id, avg(rental_rate) as avg_rental_rate from film
join film_category using (film_id)
group by category_id;
-- (3) show only the categories where #2's value is bigger than #1's value.
select category_id, avg(rental_rate) as avg_rental_rate from film
join film_category using (film_id)
group by category_id
having avg_rental_rate > (select avg(rental_rate) as avg_rental_rate from film);    
-- ----------------------------------------------------------------------------------------------------------------------
-- For each customer, show their name and how many distinct films they've rented (not total rentals — distinct films), using a correlated subquery in SELECT.                                
select customer_id, first_name,last_name, (select count(distinct film_id) from rental
											join inventory using (inventory_id)
                                            where rental.customer_id=customer.customer_id
											) as distinct_film_count 
from customer;                                            
-- The subquery is already correlated — it's filtered down to just one customer's rentals via WHERE rental.customer_id = customer.customer_id. 
-- Since it's only looking at one customer's rows at a time, grouping by customer_id inside there doesn't do anything useful  
-- ----------------------------------------------------------------------------------------------------------------------
-- Find all customers who have NOT rented anything from store 2.
select * from customer
where customer_id not in (select customer_id from rental
						where inventory_id in (select inventory_id from inventory
												where store_id = 2));
                                                
select * from customer
where customer_id not in (select customer_id from rental
						join inventory using (inventory_id)
                        where store_id =2);
                        
-- Both give the same correct result, but there's a meaningful difference: 
-- your first version (nested subquery with IN inside IN) is generally the better/safer pattern for NOT IN specifically.
-- Here's why: NOT IN combined with a subquery that uses a JOIN can be risky if any row in that joined result has a NULL in the column you're checking (customer_id in this case). 
-- If even one NULL sneaks into the subquery's result list, NOT IN will return zero rows for everything — a well-known SQL gotcha. 
-- This is because comparing anything to NULL gives UNKNOWN, not TRUE or FALSE, and NOT IN needs every comparison to definitively resolve to FALSE to include a row.
                             