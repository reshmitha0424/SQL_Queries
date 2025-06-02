-- Limit and Aliasing 

-- Limit - specify how many rows that are needed in the output
-- Aliasing - a way to change the name of a column

-- Limit
SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT * 
FROM parks_and_recreation.employee_demographics
LIMIT 3;
-- gives top 3 rows

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 5;
-- gives top 5 rows that has top 5 ages. (5 oldest employees)

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 3; -- start at position 2 and get 3 rows after that. 2 is exclusive, 2+3 is inclusive. (2, 2+3]


-- ------------------
SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age)>40;

SELECT gender, AVG(age) AS avg_age -- aliasing is done for this.
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age>40;





