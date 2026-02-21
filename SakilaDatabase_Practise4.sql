-- Window Functions

-- (1) List each customer and the number of rentals they have made. (Use COUNT() as a window function.)
select * from sakila.customer as cust;

select * from sakila.rental;

select cust.first_name, cust.last_name, cust.customer_id, rental.rental_id, 
count(rental_id) over(partition by cust.customer_id) as total_rentals
from sakila.customer as cust
join sakila.rental as rental
on rental.customer_id = cust.customer_id;


-- (2) Display each rental with the rental date and total rentals made by the same customer.
select rental_id, rental_date, cust.first_name, cust.last_name, cust.customer_id,
count(rental_id) over(partition by cust.customer_id) as total_rentals
from sakila.customer as cust
join sakila.rental as rental
on rental.customer_id = cust.customer_id;


-- (3) List all films and their lengths along with the average length of films in the same category. (Use AVG() as a window function.)
select * from sakila.film; -- film id, length
select * from sakila.film_category;-- film id, cat id
select * from sakila.category; -- cat id


select film.film_id, film.length, cat.category_id,
avg(film.length) over(partition by cat.category_id) as avg_len_per_categ
from sakila.film as film
join sakila.film_category as filmcat
using (film_id)
join sakila.category as cat
using (category_id);

-- (4) For each film, show the title, category, and the maximum film length within that category.
select * from sakila.film; -- title, filmid, length
select * from sakila.film_category;-- film id, cat id
select * from sakila.category; -- cat id

select film.title as film_title, cat.name as category,
max(film.length) over(partition by cat.category_id) as max_len_per_categ
from sakila.film as film
join sakila.film_category as filmcat
using (film_id)
join sakila.category as cat
using (category_id);

-- (5) Show each payment and the running total of payments made by the same customer.
select * from sakila.customer; 
select * from sakila.payment; -- custid, amt,

select pay.payment_id, cust.first_name, cust.last_name, cust.customer_id, pay.payment_date,
sum(amount) over(partition by cust.customer_id order by payment_date) as running_total_payment
from sakila.customer as cust
join sakila.payment as pay
using (customer_id);


-- (6) List each film and how many times it has been rented. (Use COUNT() as a window function.)


-- Show each actor and the total number of films they have acted in.

-- Display each payment along with the average payment amount made by the same customer.

-- List each staff member and the number of payments they processed.

-- Show each film and its replacement cost along with the minimum replacement cost in its category.

-- For each rental, show the rental date and the total number of rentals that happened on that day.

-- List customers and the total amount they’ve spent (as a window function).

-- Show each film with its rating and the average rental duration for that rating.

-- Display each rental with the maximum rental ID seen so far per customer.

-- List payments and rank them by amount within each customer.