use sakila;
show tables;
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

                    