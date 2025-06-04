-- subqueries
-- (1)List the titles of films that have never been rented.
select * from sakila.film; -- title, film id, 
select * from sakila.inventory; -- inventory id, film id,
select * from sakila.rental; -- rental id, inventory id 

select count(distinct film_id) from sakila.film; -- 1000

select count(distinct film_id) from sakila.inventory; -- 958

select count(distinct inventory_id) from sakila.rental; -- 4580


select title from sakila.film
where film_id not
in (select film_id 
	from sakila.inventory
	where inventory_id 
    in (select inventory_id  -- nested queries
		from sakila.rental
        )
	);

select title from sakila.film
where film_id not
in (select film_id 
	from sakila.inventory i 
	join sakila.rental r -- Using join
    on r.inventory_id = i.inventory_id
	);


select title from sakila.film
where not exists (select film_id  -- using NOT EXISTS is safer than NOT IN, as NOT IN might also give the null values. 
	from sakila.inventory i 
	join sakila.rental r -- Using join
    on r.inventory_id = i.inventory_id
	);

-- -------------------------------
-- (2) Find customers who have rented at least one film in the "Comedy" category.
select * from sakila.customer; -- custid, firstname, lname
select * from sakila.rental; -- custid, inv id
select * from sakila.inventory; -- inv id, film id
select * from sakila.film_category; -- film id, cat_id
select * from sakila.category; -- cat id

select distinct name from sakila.category;

select concat(first_name, ' ', last_name) as Cutomer_name
from sakila.customer 
where sakila.customer.customer_id 
in (
	select customer_id 
	from sakila.rental
	join sakila.inventory
	on sakila.rental.inventory_id=sakila.inventory.inventory_id
	where sakila.inventory.film_id 
	in (
		select film_id from sakila.film_category 
		join sakila.category 
		on sakila.category.category_id=sakila.film_category.category_id
		where sakila.category.name='Comedy'
		));
     
-- -------------------------------
-- (2) Find customers who have rented every film in the "Comedy" category.  
select sakila.customer.customer_id 
from sakila.customer 
where not exists(
	select sakila.film_category.film_id
    from sakila.film_category
    join sakila.category 
    on sakila.film_category.category_id = sakila.category.category_id
    where sakila.category.name = 'Horror'
    and sakila.film_category.film_id not in(
		select sakila.inventory.film_id 
		from sakila.rental
		join sakila.inventory
		on sakila.rental.inventory_id=sakila.inventory.inventory_id
		where sakila.rental.customer_id = sakila.customer.customer_id
        )
	);
    
    

-- ------------------
select * from sakila.customer; -- cust id
select * from sakila.rental; -- rental id, cust id, inv id
select * from sakila.inventory; -- inv id, film id
select * from sakila.film_category; -- film id, cat id
select * from sakila.category; -- cat id

-- 