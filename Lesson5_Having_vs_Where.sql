-- HAVING vs WHERE

SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

-- SELECT gender, AVG(age)
-- FROM parks_and_recreation.employee_demographics
-- WHERE AVG(age)>40
-- GROUP BY gender;

-- The above code gives an error - "Invalid use of groupby function"
-- because, the aggregate function is performed only after the rows are grouped by gender.
-- so we cant filter out the avg(age) before group by statement. 
-- avg(age) hasnt really been created before the grouping is not done. 


-- So we use HAVING in this place
SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age)>40;
-- HAVING is used to filter after the GROUP BY has been done. 


-- ----------------
SELECT *
FROM parks_and_recreation.employee_salary;


SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
GROUP BY occupation;

-- in the below scenario we can use both WHERE and HAVING in the same query
SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary)>75000; -- HAVING is used only on the aggregated functions only after the GROUP BY runs. 





