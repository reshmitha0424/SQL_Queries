USE sakila;
select * from rental;
-- 1. Get a list of all rentals along with the customer's first and last name who rented them.
select customer_id, first_name, last_name, rental_id, rental_date from rental
join customer 
using (customer_id);
-- USING (customer_id) works fine here since both tables share that exact column name.

-- 2. Get a list of all films along with their category name.
select title as film_name, name as category_name from film
join film_category
using (film_id)
join category
using (category_id);

-- 3. Find all customers along with their address (city and country)
select first_name, last_name, city, country from customer
join address
using (address_id)
join city 
using (city_id)
join country using (country_id);


-- 4. List all payments made by customers, showing customer first/last name, payment amount, and payment date.
select payment_id, first_name, last_name, amount as payment_amount, payment_date from payment
join customer using (customer_id);

-- 5. Find all films that have never been rented (hint: think about which join type shows unmatched rows).
select * from film
left join inventory using (film_id)
left join rental using (inventory_id)
where rental_id is NULL;

-- 6. List all actors and the films they've acted in, showing actor full name and film title.
select concat(first_name,' ',last_name) as actor_name, title as film_name from actor
join film_actor using (actor_id)
join film using (film_id);

-- 9. Find all customers who live in the same city as another customer — a self join on the customer/address/city chain, 
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

-- 10. List the store id along with the staff member's first and last name who manages that store.
select store.store_id, first_name, last_name from store
join staff 
on store.manager_staff_id = staff.staff_id;
-- Using an explicit ON clause since the join columns have different names (manager_staff_id vs staff_id)

-- 11. Find all films along with their language name (join film → language).
select film_id, title as film_name, name as language_name from film
join language using (language_id);

-- 12. Get a list of customers who have never made a payment (again — think about which join exposes "no match").
select * from customer
left join payment using (customer_id)
where payment_id is NULL;

-- 13. Find the total amount paid by each customer, showing customer name and their total payment sum, sorted by total descending (this previews GROUP BY, which we haven't formally covered yet — give it a shot with what you know, or hold off if you'd rather wait for Day 3's aggregation lesson).
select customer_id, first_name, last_name, sum(amount) as total_sum from customer
join payment using (customer_id)
group by customer_id
order by total_sum desc;

-- 14. Find all films along with their actors' names, but only for films rated 'R', sorted alphabetically by film title.
select film_id, title as film_name, first_name, last_name from film
join film_actor using (film_id)
join actor using (actor_id)
where rating = "R"
order by title;