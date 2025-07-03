 -- SELECT STATEMENT
 
 SELECT * FROM parks_and_recreation.employee_demographics; -- everything in the table
 
 SELECT first_name FROM parks_and_recreation.employee_demographics; -- only one column
 
 SELECT first_name, last_name, birth_date FROM parks_and_recreation.employee_demographics; -- three columns
 
 SELECT first_name, last_name, birth_date, age, (age+10)*2 FROM parks_and_recreation.employee_demographics;
#any math calculations are done using PEMDAS rule 
# PEMDAS- Paranthesis, exponential, mult, div, add, sub


-- DISTINCT VALUES 
 SELECT DISTINCT first_name FROM parks_and_recreation.employee_demographics;
 SELECT DISTINCT gender FROM parks_and_recreation.employee_demographics; 
 SELECT DISTINCT first_name, gender FROM parks_and_recreation.employee_demographics; -- gives uniques combinations of firstname-gender
 
 
 
 


 
 
