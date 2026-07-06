use sakila;

-- 1. Find all films whose rental rate is higher than the average rental rate (use a subquery in WHERE).
select * from film
where rental_rate > (select avg(rental_rate) from film);

-- 2. Find all customers who have never rented a film (solve this using a subquery with NOT IN, instead of the join method from Day 2).
select * from customer
where customer_id not in (select customer_id from rental);

-- 3. Find the film(s) with the maximum rental rate.
select * from film
where rental_rate = (select max(rental_rate) from film);

-- 4. Find all films that belong to the same category as the film 'ACADEMY DINOSAUR' (subquery to first find its category_id, then use it in the outer query).
select * from film
join film_category using (film_id)
where category_id = (select category_id from film
					join film_category using (film_id)
					where film.title = 'ACADEMY DINOSAUR');

-- 5. Find all customers whose total payments are above the overall average total-payment-per-customer (this needs a subquery in the FROM or WHERE — think about what the "average total per customer" means first).
select customer_id, sum(amount) as total_payment_per_customer from payment
group by customer_id
having sum(amount) > (
					select avg(total_payment_per_customer) from (
																select customer_id, sum(amount) as total_payment_per_customer from payment
																group by customer_id)as a
                                                                );
                                        
-- Subquery in FROM → called a derived table (sometimes "inline view"). It produces a temporary result set that acts like a real table for the rest of the query — that's why you have to give it an alias (like your AS a), since SQL treats it as if it were a named table.
-- Subquery in WHERE → just called a subquery (or "nested query"). It doesn't need an alias because it's not being treated as a table — it's producing either a single value (like your Q1: > (SELECT AVG(...))) or a list of values (like your Q2: NOT IN (SELECT customer_id ...)) that gets used directly inside the comparison.
-- Subquery in SELECT → sometimes called a scalar subquery, because it must return exactly one value per row (a single number/text), used to compute an extra column value.

-- 6. For each customer, find their most recent rental date (a subquery in SELECT, correlated to the outer customer row).
select customer_id, first_name, last_name, (select max(rental_date) from rental
											where rental.customer_id = customer.customer_id) as most_recent_rental
from customer;                                            
-- The inner subquery runs once per row of the outer customer table, not just once overall.
-- Each time it runs, customer.customer_id refers to whatever customer row the outer query is currently processing.
-- The subquery uses that specific customer_id to filter rental, then finds the MAX(rental_date) among just that customer's rentals.
-- This makes it "correlated" — the inner query depends on ("correlates with") the outer row, unlike a normal subquery that computes one fixed value used for every row.
-- Result: each customer gets their own personalized most_recent_rental value, calculated fresh for them.

-- 7. Find all films that have a longer length than the average length of films in their own category 
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

                    
-- 8. Find actors who have not appeared in any film (subquery with NOT IN or NOT EXISTS).
select * from actor 
where actor_id not in (select actor_id from film_actor);

-- 9. Find the second most expensive film by rental rate (without using LIMIT/OFFSET — think subqueries).
select * from film
where rental_rate = (select max(rental_rate) from film
					where rental_rate < (select max(rental_rate) from film));
-- Find the overall max rental_rate (that's the "most expensive")
-- Now look only at films where rental_rate is less than that max
-- Find the max rental_rate within that smaller group — that's the second most expensive

                    
-- 10. Find customers who have rented more films than the average number of rentals per customer.
-- average number of rentals per customer:
select avg(rental_count) from (select customer_id, count(rental_id) as rental_count from rental
								group by customer_id) as customer_rentals;
-- customers whose own rental count is above that average:
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id
HAVING rental_count > (select avg(rental_count) from (select customer_id, count(rental_id) as rental_count from rental
								group by customer_id) as customer_rentals);   
                                
-- 11. Find all films whose length is greater than the average length of all films
select * from film
where length > (select avg(length) as avg_length from film);
				
-- 12. Find all customers who have rented from the store with store_id = 1 (subquery: first find which customer_ids show up in rentals tied to store 1, via inventory → store).
select * from customer 
where customer_id in (select customer_id from rental
					where inventory_id in (select inventory_id from inventory
											where store_id=1));                      

-- 13. Find the film with the minimum rental rate 
select * from film
where rental_rate = (select min(rental_rate) from film);

-- 14. Find all actors who appeared in the film 'ACADEMY DINOSAUR' (subquery to first find the film_id, then use it to find actor_ids in film_actor, then get their names from actor).
select * from actor
where actor_id in (select actor_id from film_actor
				where film_id = (select film_id from film
								where title = 'ACADEMY DINOSAUR'));            
                
-- 15. For each film, show its title and the number of times it's been rented — using a correlated subquery in SELECT (hint: similar structure Q6, but counting rentals via inventory instead of finding a max date).
select film_id, title, (select count(*) from rental
						join inventory using (inventory_id)
                        where inventory.film_id = film.film_id) as times_rented
from film;
-- 16. Find all categories whose average film rental_rate is higher than the overall average rental_rate across all films (correlated-style: first get overall average as one subquery, then compare each category's own average against it — think about whether this needs GROUP BY + HAVING, or a correlated subquery, or both).
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

-- Find customers whose total number of rentals is higher than customer_id 1's total number of rentals (subquery to first find customer 1's rental count, then compare others against it).
-- Find all films that are NOT in the category 'Action' (subquery with NOT IN, using the film_category/category chain).

-- Stretch:

-- Find the third most expensive film by rental rate (extend the "second most expensive" pattern from Day 4 Q9 one level deeper).
-- For each customer, show their name and how many distinct films they've rented (not total rentals — distinct films), using a correlated subquery in SELECT.                                