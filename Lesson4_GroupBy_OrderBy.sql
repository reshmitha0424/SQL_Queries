-- GROUP BY 

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender; -- all the rows are rolled up into the 2 rows female and male. 

-- in the select statement , there is first_name column which is not an aggregated column.
-- when it is not an aggregated column like AVG(), the column in the select statement and group by clause have to match like above. 

-- SELECT first_name 
-- FROM parks_and_recreation.employee_demographics
-- GROUP BY gender;

-- the above code gives an error, because the first_name column is a non-aggregated column. 

SELECT gender, AVG(age) -- this is an aggregate function
FROM parks_and_recreation.employee_demographics
GROUP BY gender;
-- gives the avg age in female and male

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age) -- there are aggregate functions
FROM parks_and_recreation.employee_demographics
GROUP BY gender;
-- gives the avg age, min, max ages, count in female and male

-- --------
SELECT *
FROM parks_and_recreation.employee_salary;

SELECT occupation
FROM parks_and_recreation.employee_salary
GROUP BY occupation;

SELECT occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary;

-- ------------------------------
-- ORDER BY

SELECT *
FROM parks_and_recreation.employee_demographics;


SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name; -- ascending order by default 

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC; -- descending order

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender; -- orders by gender

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age; -- orders by gender, then by age

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC; -- gender in asc & age in desc

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age, gender; -- there is no use ordering in this aspect. 

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4; -- we can order by column positions instead of column names - not recommended. 



