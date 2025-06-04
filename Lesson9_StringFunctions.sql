-- String Functions 
-- builtin functions

-- LENGTH--------------------------
SELECT LENGTH('hellow world!');

select first_name, length(first_name)
from parks_and_recreation.employee_demographics;


select first_name, length(first_name)
from parks_and_recreation.employee_demographics
order by 2; -- sorting by second column

-- UPPER---------------------------
select upper('sky');

select first_name, upper(first_name)
from parks_and_recreation.employee_demographics;


-- LOWER---------------------------
select LOWER('sky');

select first_name, LOWER(first_name)
from parks_and_recreation.employee_demographics;

-- TRIM ---------------------------
-- we have LEFT TRIM and RIGHT TRIM
-- it takes off the white space 

select trim('  sky      '); -- removes spaces both sides 
select length(trim('  sky      '));

select ltrim('  sky      '); -- removes spaces in the front
select length(ltrim('  sky      '));

select rtrim('  sky      '); -- removes spaces at the end
select length(rtrim('  sky      '));

select first_name, 
left(first_name, 4),
right(first_name, 4) 
from parks_and_recreation.employee_demographics;


-- SUBSTRINGS --------------------
select first_name, 
substring(first_name, 3, 2) -- starts from 3rd position, takes 2 characters. 
from parks_and_recreation.employee_demographics;

select birth_date, 
substring(birth_date, 6, 2) as month_number -- gives the month number 	
from parks_and_recreation.employee_demographics;

-- REPLACE ---------------------
-- replace will replace a specific character with the specified character
select * from parks_and_recreation.employee_demographics;
select first_name, replace(first_name, 'a','z') -- replaces every instance of 'a' in firstname as 'z'
from parks_and_recreation.employee_demographics; 


-- LOCATE ------------------------
select locate('x', 'Alexandar'); -- looks for the position of x in the word

select first_name, locate('An',first_name) -- locates every instance of 'An' in firstname 
from parks_and_recreation.employee_demographics;

-- CONCAT -----------------------
select first_name, last_name,
concat(first_name,' ',last_name) -- combines strings. 
from parks_and_recreation.employee_demographics;




