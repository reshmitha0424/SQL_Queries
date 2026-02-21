use sakila;
show tables;
-- 1. List all films whose rental rate is greater than the average rental rate.
select title, rental_rate from film
where rental_rate > (select avg(rental_rate) from film)
order by rental_rate;

-- 2. List all customers who have made at least one payment.
select count(distinct customer_id) from payment;

select count(*) from customer;

select customer_id, first_name, last_name from customer
where customer_id in (select customer_id from payment);


-- 3. List all customers who have never made a payment.
select customer_id, first_name, last_name from customer
where customer_id not in (select customer_id from payment);
