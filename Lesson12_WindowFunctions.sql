-- Window Functions

-- similar to group by, but doesnt group evrytihng around one row
-- allow us to look at a partition or a group but they each keep their own unique rows in the output. 

select * 
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;


select gender, avg(salary) as avg_sal
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id
group by gender; -- rolls everything up into one row


select gender, avg(salary) over() -- avg sal over everybody
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;


select gender, avg(salary) over(partition by gender)  -- similar to group by , but everything is not rolling up to one row. 
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;


select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender) 
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;

select dem.first_name, dem.last_name, gender, avg(salary) 
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id
group by dem.first_name, dem.last_name, gender;
-- here we are grouping whole thing by dem.first_name, dem.last_name, gender
-- here the avg salary values will be different from the previous one


-- -------------------------------------

select dem.first_name, dem.last_name, gender, sum(salary) over(partition by gender) 
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;


-- ROLLING TOTAL - starts at a specific value, add values from subsequent rows based on partition (like cummulative)
select dem.first_name, dem.last_name, gender, salary, sum(salary) over(partition by gender order by dem.employee_id) as Rolling_Total
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;

-- ------------------------------------
-- ROW NUMBER 

select dem.employee_id, dem.first_name, dem.last_name, gender, salary, row_number() over() -- over everything
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;
-- here, there will be no repition in row numbers as we have done over() i.e, over everything

select dem.employee_id, dem.first_name, dem.last_name, gender, salary, row_number() over(partition by gender)
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;
-- row number starts again for a new value in gender. 

select dem.employee_id, dem.first_name, dem.last_name, gender, salary, row_number() over(partition by gender order by salary desc)
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;
-- row number doesn't have duplicates inside the partition

-- -----------------------------
-- RANK 

select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;
-- rank is similar to row number, but if there is same value for the row mentioned in order by, it gives the same rank 
-- when a rank 5 is repeated twice, rank 6 is skipped. (it gives the rank positionally)

-- DENSE RANK

select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as denserank_num
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id;
-- similar to rank but when 5 is repeated twice, 6 is not skipped (gives the rank numerically, not positionally)








