-- Window functions

-- Level1--
-- (1) Assign row numbers to each payment
select payment_id, amount, payment_date, row_number() over(order by payment_date) as row_num 
from sakila.payment;

-- (2) Assign row numbers per customer
select payment_id, amount, payment_date, customer_id,
row_number() over(partition by customer_id order by payment_date) as row_num
from sakila.payment;

-- (3) Get total amount paid by each customer (on every row)
select customer_id, amount, payment_date,
sum(amount) over(partition by customer_id) as customer_totals
from sakila.payment;

-- Level2--
-- (1) Running total of payments for each customer
select customer_id, amount, payment_date,
sum(amount) over(partition by customer_id order by payment_date) as customer_totals
from sakila.payment;

-- (2) Rank customers by total payment made
select customer_id, amount, payment_date,
sum(amount) over(partition by customer_id) as customer_totals,
rank() over(order by sum(amount) over(partition by customer_id) desc) as ranks
from sakila.payment;

select customer_id, amount, 
sum(amount) over(partition by customer_id) as customer_totals,
rank() over(order by customer_totals desc) as ranks
from 
	(select customer_id, amount, sum(amount) over(partition by customer_id) as customer_totals
    from sakila.payment
    ) as customer_totals
;


SELECT
    customer_id,
    SUM(amount) AS total_paid,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS payment_rank
FROM sakila.payment
GROUP BY customer_id
ORDER BY payment_rank;

