-- Subqueries
-- just a query withinn another query

-- (1) using WHERE clause
select * 
from parks_and_recreation.employee_demographics;
select * 
from parks_and_recreation.employee_salary;
-- the employees who worked in the parks and rec dept. 

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE employee_id 
IN (
	select employee_id -- inside the subquery we need to have only one column here 
    from parks_and_recreation.employee_salary
    where dept_id=1
);

-- (2) using SELECT statement 
select * 
from parks_and_recreation.employee_salary;

select first_name, last_name, avg(salary) as avg_salary
from parks_and_recreation.employee_salary
group by first_name, last_name;

select first_name, last_name,
	(select avg(salary) 
	from parks_and_recreation.employee_salary) as avg_salary
from parks_and_recreation.employee_salary;

-- (3) using FROM statement 
select * 
from parks_and_recreation.employee_demographics;

select gender, avg(age), min(age), max(age), count(age)
from parks_and_recreation.employee_demographics
group by gender;

select * 
from (
	select gender, avg(age), min(age), max(age), count(age)
	from parks_and_recreation.employee_demographics
	group by gender) 
as aggregated_table; -- gives the same outpt as before

select avg(`max(age)`) as avg_max_age -- we are using backticks(``) and not quotes ('')
from (
	select gender, avg(age), min(age), max(age), count(age)
	from parks_and_recreation.employee_demographics
	group by gender) 
as aggregated_table; -- this gives the average of max ages of both genders. 
-- avg(`max(age)`)  here we are specifying `max(age)` as the name of the column and not aggregate function 

select avg(max_age) as avg_max_age 
from (
	select gender, 
    avg(age) as avg_age, 
    min(age) as min_age, 
    max(age) as max_age, 
    count(age) as count_age
	from parks_and_recreation.employee_demographics
	group by gender) 
as aggregated_table;


