USE sakila;
show tables;

-- ### (1) Basic SELECT & Filtering ###
-- 1. List the first 10 actors’ first and last names from the actor table.
select first_name, last_name from actor
limit 10;

-- 2. From the film table, show the title and release year of all films released after 2005.
select title, release_year from film
where release_year>2005;

-- 3. In the customer table, Find all customers who have an active status = 1
select * from customer
where active=1;

-- 4. Get the distinct store IDs from the inventory table.
select distinct store_id from inventory;

-- 5. Show all payments from the payment table where the amount is greater than 5, ordered from highest to lowest amount.
select * from payment
where amount>5
order by amount desc;

-- 6. List the first name, last name, and email of customers from the customer table who belong to store_id = 2.
select first_name, last_name, email from customer
where store_id=2;

-- 7. From the film table, list all films that have a rental duration of more than 5 days.
select * from film
where rental_duration>5;

-- 8. From the rental table, find all rentals made after January 1, 2006.
select * from rental
where rental_date> '2006-01-01'; 
-- need to enclose the date in quotes so MySQL reads it as a date literal, not a math expression.

-- 9. From the payment table, find the total amount paid by each customer.
select customer_id, sum(amount) from payment
group by customer_id;

-- 10. From the payment table, find the average payment amount made by each staff member.
select staff_id, avg(amount) from payment
group by staff_id;

-- 11. From the film table, find the number of films in each rating category.
select rating, count(title) from film
group by rating;

-- 12. From the film table, find the average rental rate for each rating category, ordered from highest to lowest average.
select rating, avg(rental_rate) as avg_rental_rate from film
group by rating
order by avg_rental_rate desc;

-- 13. From the customer table, count how many customers belong to each store_id.
select store_id, count(customer_id) from customer
group by store_id;

-- 14. From the film table, list all films that have a rental rate between 2 and 4.
select title from film
-- where 2<rental_rate<4;  MySQL doesn’t interpret chained comparisons like Python.
WHERE rental_rate BETWEEN 2 AND 4;

-- 15. From the film table, find all films whose title starts with ‘A’.
select title from film
where title like "A%";

-- 16. From the film table, list all films whose title ends with ‘S’.
select title from film
where title like "%S";

-- 17. From the film table, find all films whose title contains the word ‘LOVE’ (anywhere in the title).
select title from film
where title like "%LOVE%";

-- 18. From the address table, list all addresses that are located in district = 'California'.
select * from address
where district="California";

-- 19. From the customer table, list customers whose last name contains the letter ‘Q’.
select * from customer
where last_name like "%Q%";

-- 20. From the film table, find the maximum, minimum, and average rental rates.
select max(rental_rate) as max_rate, min(rental_rate) as min_rate, avg(rental_rate) as avg_rate from film;

-- 21. From the payment table, find the total amount paid for each payment date.
select date(payment_date) as pay_date, sum(amount) as total_amt from payment
group by pay_date;

-- 22. From the film table, find how many films have a replacement cost greater than 20.
select count(film_id) as cnt from film
where replacement_cost>20;

-- 23. From the film table, find the average length of films in each rating category.
select rating,avg(length) from film
group by rating;

-- 24. From the film table, find the maximum rental rate for each replacement cost value.
select replacement_cost, max(rental_rate) as max_rate from film
group by replacement_cost;

-- 25. From the film table, find all films whose description contains the word ‘Epic’.
select * from film
where description like "%Epic%";










