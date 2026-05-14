-- Subqueries

select * from employee_demographics  
where employee_id in 
(select employee_id from employee_salary where 
dept_id =1);

select first_name,salary ,
(select avg(salary) 
from employee_salary) as 'Avrage salary' 
from employee_salary ;

select gender,avg(age),count(age),max(age),min(age)
from employee_demographics group by gender;

select avg(`min(age)`)   from
(select gender,
avg(age),count(age),max(age),min(age)
from employee_demographics group by gender)
as agg_table
;

select avg(min_age)   from
(select gender,
avg(age) as avg_age,
max(age) as max_age,
min(age) as min_age
,count(age)
from employee_demographics group by gender)
as agg_table
;

-- Select all data from employee_salary 
-- for employees who belong to 
-- department 1 and are older than 30 years old.

select * from employee_salary 
where dept_id=6 and employee_id in
( select employee_id from employee_demographics 
where age > 30);

