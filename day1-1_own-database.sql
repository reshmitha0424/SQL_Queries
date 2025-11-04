CREATE DATABASE testdb;
USE testdb;

-- creating a simple table 
create table employees(
	emp_id int primary key,
    emp_name varchar(50),
    department varchar(30), 
    salary decimal(10,2),
    hire_date date
);

-- insert data
insert into employees values
(1, 'Alice', 'HR', 55000, '2020-03-10'),
(2, 'Bob', 'Finance', 72000, '2019-07-22'),
(3, 'Charlie', 'IT', 88000, '2021-01-15');

-- basic queries
select * from employees;

select emp_name, department from employees;

select emp_name, salary*1.1 as new_salary from employees;