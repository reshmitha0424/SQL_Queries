-- Unions

-- allows to combine rows together from different tables or from the same table

SELECT *
FROM parks_and_recreation.employee_demographics
UNION
SELECT *
FROM parks_and_recreation.employee_salary
;

SELECT age, gender 
FROM parks_and_recreation.employee_demographics
UNION
SELECT first_name, last_name
FROM parks_and_recreation.employee_salary
;
-- this is not the correct thing to do. we cant just randomly append any rows 

SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics
UNION -- this is distinct 
SELECT first_name, last_name
FROM parks_and_recreation.employee_salary
;
-- same rows from both the tables can be combined. this gives all the rows in both tables combined.

SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics
UNION ALL
SELECT first_name, last_name
FROM parks_and_recreation.employee_salary
;
-- gives all the rows without removing duplicates. 


SELECT first_name, last_name, 'Old' AS Label -- adding a label.
FROM parks_and_recreation.employee_demographics
WHERE age>50
;



SELECT first_name, last_name, 'Old' AS Label -- adding a label.
FROM parks_and_recreation.employee_demographics
WHERE age>50
UNION
SELECT first_name, last_name, 'Highly paid employee' AS Label -- adding a label.
FROM parks_and_recreation.employee_salary
WHERE salary>70000
;

SELECT first_name, last_name, 'Old Man' AS Label -- adding a label.
FROM parks_and_recreation.employee_demographics
WHERE age>40 and gender = 'male'
UNION 
SELECT first_name, last_name, 'Old Lady' AS Label -- adding a label.
FROM parks_and_recreation.employee_demographics
WHERE age>40 and gender = 'female'
UNION
SELECT first_name, last_name, 'Highly paid employee' AS Label -- adding a label.
FROM parks_and_recreation.employee_salary
WHERE salary>70000
;

-- Leslie and Chris are appearing twice - as Old man, Old Lady and Highly paid employee

SELECT first_name, last_name, 'Old Man' AS Label -- adding a label.
FROM parks_and_recreation.employee_demographics
WHERE age>40 and gender = 'male'
UNION 
SELECT first_name, last_name, 'Old Lady' AS Label -- adding a label.
FROM parks_and_recreation.employee_demographics
WHERE age>40 and gender = 'female'
UNION
SELECT first_name, last_name, 'Highly paid employee' AS Label -- adding a label.
FROM parks_and_recreation.employee_salary
WHERE salary>70000
order by first_name, last_name
;



