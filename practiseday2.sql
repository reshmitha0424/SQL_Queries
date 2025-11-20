use sakila;

-- 1.List all films along with their category names.
select * from film;
select * from film_category;
select * from category;

select film.title as film_name, category.name as category_name from film
join film_category
using (film_id)
join category
using (category_id);

-- 2. Show each customer and how many rentals they have made, showing 0 if they made none.
select customer_id, count(rental_id) from customer
left join rental
using (customer_id)
group by customer_id;

-- 3. Find all categories that have more than 80 films.
select name, count(film_id) as numfilms from film_category
join category
using (category_id)
group by name
having numfilms > 80
order by numfilms desc;

-- 4. Show each rental with the film title, customer name, and rental date.
select * from film; -- title -- film_id
select * from inventory; -- film_id, inventory_id
select * from rental; -- rental date -- customer_id, rental_id, inventory_id
select * from customer; -- customer name -- customer_id

select r.rental_id, f.title as film_name, concat(c.first_name,' ',c.last_name) as customer_name, r.rental_date from film as f
join inventory as i
using (film_id)
join rental as r
using (inventory_id)
join customer as c
using (customer_id)
order by rental_id;

-- 5. List all films that belong to the category “Action.”
select title as film_name, name as category_name from film
join film_category
using (film_id)
join category
using (category_id)
where name = "Action";

-- 6. List customers who have paid more than the average amount that customer pays.
select concat(first_name, ' ', last_name) as customer_name, amount from customer
join payment
using (customer_id)
where amount > (select avg(amount) from payment)
order by amount;

select concat(first_name, ' ', last_name) as customer_name, sum(amount) as total_amount from customer
join payment
using (customer_id)
group by customer_name
having total_amount > (select avg(amount) from payment)
order by total_amount;

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    customer_totals.total_paid
FROM (
    SELECT customer_id, SUM(amount) AS total_paid
    FROM payment
    GROUP BY customer_id
) AS customer_totals
JOIN customer c USING (customer_id)
WHERE customer_totals.total_paid >
      (SELECT AVG(total_paid)
       FROM (
           SELECT SUM(amount) AS total_paid
           FROM payment
           GROUP BY customer_id
       ) AS totals_per_customer)
ORDER BY total_paid DESC;


-- 7. Find the first rental made by each customer.
select * from(
		select customer_id, rental_id, rental_date, 
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_date) as ranks 
        from customer
		join rental
		using (customer_id)
) as t
where ranks = 1;
-- SQL doesn’t let you filter on an alias of a window function at the same level - so we need subquery

-- 8. Find the top 3 highest-revenue films within each rating.
select * from (
				select title, rating, rental_rate, 
				ROW_NUMBER() OVER (PARTITION BY rating ORDER BY rental_rate desc) 
                as ranks from film
) as t
where ranks<=3;
-- WRONG FOR THE QUESTION ASKED

-- 9. List all films that have never been rented.
select film_id, title from film
left join inventory
using (film_id)
left join rental
using (inventory_id)
where rental_id is null;

-- 10. Combine the list of customers whose first name starts with 'A' and customers whose last name starts with 'S' into one result.
select concat(first_name, ' ', last_name) from customer
where first_name like "A%" and last_name like "S%";


