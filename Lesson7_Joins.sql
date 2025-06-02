-- Joins

-- allows to combine two tables or more if they have a common column (need not be same col name but the data should be same)

SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT * 
FROM parks_and_recreation.employee_salary;

-- the common column is employee_id


-- INNER JOIN - returns the rows that are same in both columns in both the tables. 
-- JOIN refers by deault as INNER JOIN 
SELECT * 
FROM parks_and_recreation.employee_demographics
JOIN parks_and_recreation.employee_salary
	ON parks_and_recreation.employee_demographics.employee_id = parks_and_recreation.employee_salary.employee_id;
-- basically pulling only the rows that have the same values in both columns
-- we dont have row 2 in demographics table, so when we join the row 2 is skipped. 

-- aliasing in joins
SELECT * 
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id;


SELECT dem.employee_id, age, occupation -- if we have a column that is common in both the tables, we should mention the table name too like dem.emp_id (or) sal.emp_id
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
-- -------------
-- OUTER JOINS  - we have LEFT JOIN/ LEFT OUTER JOIN and RIGHT JOIN / RIGHT OUTER JOIN
-- LEFT OUTER JOIN - takes everything from the left table, even if there is no match in the join and then it will only return the matches from the right table
-- RIGHT OUTER JOIN - takes everything from the right table, even if there is no match in the join and then it will only return the matches from the left table

SELECT * 
FROM parks_and_recreation.employee_demographics AS dem
LEFT JOIN parks_and_recreation.employee_salary AS sal -- or LEFT OUTER JOIN  
	ON dem.employee_id = sal.employee_id;

SELECT * 
FROM parks_and_recreation.employee_demographics AS dem
RIGHT JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
-- takes everything from emp_sal table , and gives NULL wherever there is no match from the emp_dem table, like the row 2.

-- -----------------
-- SELF JOIN - tieing the table to itself. 
SELECT * 
FROM parks_and_recreation.employee_salary AS emp1
JOIN parks_and_recreation.employee_salary AS emp2
	ON emp1.employee_id = emp2.employee_id;

SELECT * 
FROM parks_and_recreation.employee_salary AS emp1
JOIN parks_and_recreation.employee_salary AS emp2
	ON emp1.employee_id+1 = emp2.employee_id;
    
-- when playing secret santa
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM parks_and_recreation.employee_salary AS emp1
JOIN parks_and_recreation.employee_salary AS emp2
	ON emp1.employee_id+1 = emp2.employee_id;
    
-- -----------------
-- joining multiple tables together
SELECT * 
FROM parks_and_recreation.employee_demographics AS dem -- table1
INNER JOIN parks_and_recreation.employee_salary AS sal -- table 2
	ON dem.employee_id = sal.employee_id;
    
SELECT *
FROM parks_and_recreation.parks_departments;

SELECT * 
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_and_recreation.parks_departments AS pd -- table3
	ON sal.dept_id = pd.department_id; -- no same name but have the same values

