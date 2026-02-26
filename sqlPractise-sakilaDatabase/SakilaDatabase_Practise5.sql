-- Basic SELECT Queries -----------------------------------
-- (1) List all customers with their first and last names.
select first_name, last_name from sakila.customer;

-- (2) Display all films with their titles and rental duration.
select title, rental_duration from sakila.film;

-- (3) Show the list of all staff members with their email addresses.
select first_name, last_name, email from sakila.staff;

-- (4) Find all information about the film with title 'ACADEMY DINOSAUR'.
select * 
from sakila.film
where title = 'ACADEMY DINOSAUR';

-- (5) List the names of all languages in the language table.
select name from sakila.language;

-- Filtering and WHERE clause -----------------------------
-- (1) Show all customers from the city 'Dallas'.
select * from sakila.customer; -- cust details, addr id
select * from sakila.address; -- addr id, city id
select * from sakila.city; -- city id, city

-- using WHERE
select first_name, last_name 
from sakila.customer
where address_id 
in (
	select address_id 
	from sakila.address
    where city_id 
    in (
		select city_id
        from sakila.city
        where city='Dallas'
        )
	);

-- using joins
select first_name, last_name 
from sakila.customer as cust
join sakila.address as addr
using (address_id)
join sakila.city as city
using (city_id)
where city = 'Dallas' ;

-- You were absolutely right to think that JOINs pull all related data into one combined table first, 
-- while subqueries using WHERE just filter based on values from another table. 
-- It’s natural to assume that JOINs might use more computational power, 
-- but in most cases, SQL engines are smart enough to optimize both approaches similarly. 
-- That said, JOINs are generally more efficient and preferred—especially when working with large datasets or when you need to access columns from multiple tables—
-- because they take better advantage of indexes and execution plans. 
-- Subqueries can be simpler for quick filters, but JOINs are often clearer, faster, and more scalable in real-world queries. 


-- (2) Find all films with a rental rate greater than 2.99.
select title, rental_rate from sakila.film
where rental_rate > 2.99;

-- (3) Get all actors whose first name is 'Nick'.
select first_name, last_name from sakila.actor
where first_name = 'Nick';

-- (4) Find all payments greater than $5.
select payment_id, customer_id, amount, payment_date
from sakila.payment
where amount>5;

-- (5) Show all films released after 2005.
select title, release_year from sakila.film
where release_year > 2005;


-- ORDER BY and LIMIT -----------------------------
-- (1) List the top 10 most expensive films by rental rate.
select title, rental_rate 
from sakila.film
order by rental_rate desc
limit 10;

-- (2) Show customers ordered by last name, then first name.
select * from sakila.customer
order by last_name, first_name;

-- (3) List all cities in alphabetical order.
select city from sakila.city
order by city;

-- (4) Get the 5 shortest films by length.
select title, length from sakila.film
order by length
limit 5;

-- (5) Find the top 3 customers who paid the most (by total amount).
select first_name, last_name, amount from sakila.payment
join sakila.customer as cust
using (customer_id)
order by amount desc
limit 5;
-- the above query is correct when asked for most 'amount' but here they asked for 'total amount'

select first_name, last_name, sum(p.amount) as total_amount
from sakila.payment as p
join sakila.customer as cust
using (customer_id)
group by customer_id
order by total_amount desc
limit 5;

-- JOINs (2-table basics) -----------------------------
-- (1) List all films along with their language name.
select * from sakila.film; -- filmid, title, lang id
select * from sakila.language; -- lang id, lang name

select f.title as film, l.name as language
from sakila.film as f
join sakila.language as l
using (language_id);


-- (2) Show customer names and the cities they live in.
select * from sakila.customer; -- cust id, address id
select * from sakila.address; -- addr id, city id
select * from sakila.city;-- city id

select c.first_name, c.last_name, city.city
from sakila.customer as c
join sakila.address as a
using (address_id)
join sakila.city as city
using (city_id);

-- (3) Get all payments made, showing customer names and payment amounts.
select * from sakila.payment; -- payid, custid, amt
select * from sakila.customer; -- cust id

select c.customer_id, first_name, last_name, sum(p.amount) as total_amt
from sakila.customer as c
join sakila.payment as p
on c.customer_id=p.customer_id
group by customer_id;

-- (4) Show a list of films and their corresponding category names.
select * from sakila.film; -- film id, 
select * from sakila.film_category; -- film id, cat id
select * from sakila.category; -- cat id

select title as film, name as category
from sakila.film 
join sakila.film_category
using (film_id)
join sakila.category
using (category_id);

-- Display the titles of films rented by customer with ID = 1.
select * from sakila.film; -- film id
select * from sakila.inventory; -- film id, inv id
select * from sakila.rental; -- inv id, rental id, cust id, 

select title as film
from sakila.film
join sakila.inventory
using (film_id)
join sakila.rental
using (inventory_id)
where customer_id=1;


-- Aggregation (GROUP BY, COUNT, SUM) -----------------------------
-- (1) Count the number of customers in each city.
select city_id, count(customer_id) as customer_count
from sakila.customer as c
join sakila.address as a
using (address_id)
group by city_id
order by city_id;


-- (2) Find the total number of films in each category.
select c.name as category, count(f.film_id) as total_films
from sakila.film as f
join sakila.film_category as fc
using (film_id)
join sakila.category as c
using (category_id)
group by c.category_id
order by total_films;

-- (3) Show the total payment made by each customer.
select c.first_name, c.last_name, sum(p.amount) as total_payment
from sakila.customer as c
join sakila.payment as p
using (customer_id)
group by customer_id;


-- (4) Find the average film rental rate.
select f.title as film, avg(f.rental_rate) as avg_rental_rate
from sakila.film as f
group by film_id
order by avg_rental_rate;

-- (5) Count the number of rentals per customer.
select customer_id, count(customer_id) as total_rentals 
from sakila.rental
group by customer_id
order by customer_id;

