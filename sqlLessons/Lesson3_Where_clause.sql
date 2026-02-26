-- WHERE Clause

-- COMPARISON OPERATORS
SELECT * 
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie'; -- == is the comparison operator

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary>50000;

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary>=50000;

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary<50000;

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE salary<=50000;


SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender != 'female';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'; -- standard default date format yyyy/mm/dd


-- LOGICAL OPERATORS 
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
AND NOT gender = 'male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name = 'Leslie'
AND age = 44;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

-- LIKE Statement 
-- % - anything 
-- _ - particular values
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'Jer%'; -- anything after 'Jer'

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%a%'; -- anything before and after 'a'

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a__'; -- has only 2 characters after 'a'


SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '1989%'; 

























