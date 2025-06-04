-- Case Statements 
-- allows to add logic in select statement 

select first_name, last_name
from parks_and_recreation.employee_demographics;	

select first_name, last_name, age,
case
	when age <= 30 then 'Young'
end as age_desc
from parks_and_recreation.employee_demographics;	


select first_name, last_name, age,
case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'old'
end as age_desc
from parks_and_recreation.employee_demographics;	


select first_name, last_name, age,
case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'old'
    when age >= 50 then 'senior citizen'
end as age_desc
from parks_and_recreation.employee_demographics;	

-- problem statement & solution----------------

select *
from parks_and_recreation.employee_salary;

select * 
from parks_and_recreation.parks_departments;
-- problem - Pay increase and bonus
-- <50000 = 5%
-- >50000 = 7%
-- finance = 10%

select first_name, last_name, salary,
case
	when salary <50000 then salary+(salary*0.05)
    when salary >50000 then salary+(salary*0.07)
end as new_Salary,
case
	when dept_id=6 then salary*0.10
end as Bonus
from parks_and_recreation.employee_salary;


