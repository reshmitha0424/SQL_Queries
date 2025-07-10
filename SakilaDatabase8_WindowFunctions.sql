-- Window Functions

-- (1) Get a list of all payments, and assign a row number to each payment within each customer, ordered by payment date (earliest to latest).
select payment_id, customer_id, payment_date, amount,
row_number() over(partition by customer_id order by payment_date) as row_num
from sakila.payment;

-- (2) For each customer, rank their payments based on amount from highest to lowest. If two payments have the same amount, they should get the same rank
select payment_id, customer_id, payment_date, amount,
rank() over(partition by customer_id order by amount desc) as ranks
from sakila.payment;

-- (3) Modify the same query to use DENSE_RANK() instead of RANK(). Explain how it differs in the output and send your query here.
select payment_id, customer_id, payment_date, amount,
rank() over(partition by customer_id order by amount desc) as ranks,
dense_rank() over(partition by customer_id order by amount desc) as denseranks
from sakila.payment;

-- (4)For each customer, divide their payments into 4 buckets (quartiles) based on payment amount. Use NTILE(4) to do it.
select payment_id, customer_id, payment_date, amount,
ntile(4) over(partition by customer_id order by amount desc) as spending_quarters
from sakila.payment
order by customer_id, spending_quarters;

-- (5) Total Amount Paid by Each Customer
select customer_id, amount,
sum(amount) over(partition by customer_id) as totals
from sakila.payment;

-- (6) show a running total of their payments in order of payment date.
select customer_id, amount,
sum(amount) over(partition by customer_id order by payment_date) as running_totals
from sakila.payment;

-- (7) For each payment, show the previous payment amount made by the same customer.
select customer_id, payment_date, amount, 
lag(amount) over(partition by customer_id order by payment_date) as previous_amount
from sakila.payment;

-- (8) For each payment, show the next payment amount made by the same customer.
select customer_id, payment_date, amount, 
lag(amount) over(partition by customer_id order by payment_date) as previous_amount,
lead(amount) over(partition by customer_id order by payment_date) as next_amount
from sakila.payment;

-- (9) For each payment, show: The first payment amount ever made by that customer; The latest (last so far) payment amount up to that row (in payment date order)
select customer_id, payment_date, amount, 
first_value(amount) over(partition by customer_id order by payment_date) as first_amount,
last_value(amount) over(partition by customer_id order by payment_date) as last_amount
from sakila.payment;