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

-- Practics subqueries

-- Q1 Find employees older than average age
SELECT first_name, age
FROM employee_demographics
WHERE age >
(
    SELECT AVG(age)
    FROM employee_demographics
);

-- Q2 Find employees belonging to department 1
SELECT *
FROM employee_salary
WHERE dept_id IN
(
    SELECT department_id
    FROM parks_departments
    WHERE department_name = 'Parks and Recreation'
);

-- Q3 Find employees working in the department with highest average salary
SELECT *
FROM employee_salary
WHERE dept_id =
(
    SELECT dept_id
    FROM employee_salary
    GROUP BY dept_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- Q4 Find employees earning the maximum salary
SELECT *
FROM employee_salary
WHERE salary =
(
    SELECT MAX(salary)
    FROM employee_salary
);

-- Q5 Find employees earning less than the average salary.
select * from employee_salary
where salary<
(select avg(salary) from employee_salary);

-- Q6 Find employees whose age is equal to the minimum age.
select * from employee_demographics
where age=(
select min(age) from employee_demographics);

-- Q7 Find employees whose salary is greater than the average salary.

select * from employee_salary
where salary>
(select avg(salary) from employee_salary);

-- Q8 Find employees working in departments that have more than 2 employees.
select  * from employee_salary
where dept_id in (
select dept_id from employee_salary
group by dept_id
having count(*)>2)
;

-- Q9 Find employees whose salary is equal to the second-highest salary.
select * from employee_salary
where salary=(
select salary from employee_salary
order by salary desc
limit 1,1);

-- Q10 Find departments whose average salary is greater than 60,000.
select * from parks_departments
where department_id in (
select dept_id from employee_salary
group by dept_id
having avg(salary)>60000);

-- Advanced Subquery Practice Set

-- Q11 Find employees whose salary is above the average salary of their own department.
select * from employee_salary sal1
where salary> (
select avg(salary) from employee_salary sal2
where sal1.dept_id=sal2.dept_id);

-- Q12 Find employees who work in the same department as the highest-paid employee.
select * from employee_salary
where dept_id=(
select dept_id from employee_salary
order by salary desc
limit 1);


-- Q13 Find the department(s) with the maximum number of employees.
select dept_id,count(*) emp_count
 from employee_salary
 group by dept_id
having count(*)=(
select max(emp_count) from 
(SELECT COUNT(*) AS emp_count
        FROM employee_salary
        GROUP BY dept_id)t);

-- Q14 Find employees whose age is above the average age of their gender.
SELECT *
FROM employee_demographics d1
WHERE age >
(
    SELECT AVG(age)
    FROM employee_demographics d2
    WHERE d1.gender = d2.gender
);
-- Q15 Find the third-highest salary using a subquery.
select * from employee_salary
where salary=(
select * from employee_salary
order by salary desc
limit 2,1);

-- Q16 Find employees whose salary is lower than the highest salary in their department.
select * from employee_salary
where salary<(
select max(salary) from employee_salary);

-- Q17 Find employees working in departments where the average salary is greater than 60,000.
select * from employee_salary
where dept_id in (
select dept_id from employee_salary
group by dept_id
having avg(salary)>60000
);
-- Q18 Find employees whose age is equal to the maximum age in their gender group.
select * from employee_demographics
where gender in (
select gender from employee_demographics
group by gender
having age=max(age));

-- Q19 Find employees who belong to departments having more employees 
-- than the average department size.
select dept_id ,count(*) as no_of_emp from employee_salary
group by dept_id
having count(*)>(
select avg(emp_count) from (
select count(*) as emp_count from employee_salary
GROUP BY dept_id
)dept_count);

-- Q20 Find employees whose salary is greater than the minimum salary of department 1.

select * from employee_salary
where salary>(
select min(salary) from employee_salary 
where dept_id =1 );

-- Q1. Find employees older than the average age.
select * from employee_demographics
where age>
(
select avg(age) from employee_demographics
);
-- Q2. Find employees belonging to department 1.
select * from employee_salary
where dept_id in (
select dept_id from employee_salary
where dept_id=1);

-- Q3. Find employees working in the department with the highest average salary.
select * from employee_salary
where dept_id=(
select dept_id from employee_salary
group by dept_id
order by avg(salary) desc
limit 1);
-- Q4. Find employees whose salary is above the company average salary.
select * from employee_salary
where salary >(
select avg(salary) from employee_salary);
-- Q4. Find employees whose salary is above the company average salary.
select * from employee_salary
where salary >(
select avg(salary) from employee_salary);
-- Q5. Find employees earning the maximum salary in the company.
select * from employee_salary
where salary =(
select max(salary) from employee_salary);
-- Q6. Find employees earning the second-highest salary.
select * from employee_salary
where salary =
(
select distinct salary from employee_salary
order by salary desc
limit 1,1
);
-- Q7. Find employees earning the third-highest salary.
select * from employee_salary
where salary=(
select distinct salary from employee_salary
order by salary desc
limit 2,1);
-- Q8. Find employees whose salary is below the company average salary.
select * from employee_salary
where salary<(
select avg(salary) from employee_salary);
-- Q9. Find employees whose age is greater than the average age of their gender group.
select * from employee_demographics e1
where age >(
select avg(age) from employee_demographics e2
 WHERE e1.gender = e2.gender

);
-- Q10. Find employees who belong to departments with more than 3 employees.
select * from employee_salary
where dept_id in (
select dept_id  from employee_salary
group by dept_id
having count(*)>3);

-- Intermediate Subqueries

-- Q11. Find employees whose salary is greater than the average salary of their department.
select * from employee_salary e1
where salary> (
select avg(salary) from employee_salary e2
where e1.dept_id=e2.dept_id)
;
-- Q12. Find departments where the average salary is less than the company average salary.
select dept_id from employee_salary
group by dept_id
having avg(salary)< (
select avg(salary) from employee_salary);
-- Q13. Find employees working in the department having the highest number of employees.
select * from employee_salary
where dept_id = (
select dept_id from employee_salary
group by dept_id
order by count(*) desc
limit 1);
-- Q14. Find employees earning the minimum salary in the company.
select * from employee_salary
where salary=(
select min(salary) from employee_salary);

-- Q15. Find employees whose age is equal to the minimum age in their gender group.
select * from employee_demographics e1
where age =(
select min(age) from employee_demographics e2
where e1.gender=e2.gender);

-- Q16. Find employees whose salary is lower than the highest salary in their department.
select * from employee_salary e1
where salary <(
select max(salary) from employee_salary e2
where e1.dept_id=e2.dept_id);
-- Q17. Find employees working in departments where the average salary is greater than 60,000.
select * from employee_salary
where dept_id in(
select dept_id from employee_salary
group by dept_id
having avg(salary)>60000);
-- Q18. Find employees whose age is equal to the maximum age in their gender group.
select * from employee_demographics e1
where age= (
select max(age) from employee_demographics e2
where e1.gender=e2.gender);
-- Q19. Find employees who belong to departments having more employees 
-- than the average department size.
select * from employee_salary
where dept_id in(
select dept_id from employee_salary
group by dept_id
having count(*)>(
select avg(emp_count)
from (
select count(*) as emp_count
from employee_salary
group by dept_id
)dept_size));
-- Q20. Find employees whose salary is greater than the minimum salary of department 1.
select * from employee_salary
where salary>(
select min(salary) from employee_salary
where dept_id=1);

-- Advanced Subqueries

-- Q21. Find employees whose salary is greater than the average salary of all employees.
select * from employee_salary
where salary>(
select avg(salary) from employee_salary);
-- Q22. Find employees whose age is less than the average age of all employees.
select * from employee_demographics e1
where age<(
select avg(age) from employee_demographics e2
);
-- Q23. Find employees working in departments where the maximum salary is greater than 70,000.
select * from employee_salary
where dept_id in (
select dept_id from employee_salary
group by dept_id
having max(salary)>70000);
-- Q24. Find employees whose salary is equal to the highest salary in their department.
select * from employee_salary e1
where salary= (
select max(salary) from employee_salary e2
where e1.dept_id=e2.dept_id);
-- Q25. Find employees whose salary is lower than the average salary of their department.
select * from employee_salary e1
where salary<(
select avg(salary) from employee_salary e2
WHERE e1.dept_id = e2.dept_id
);
-- Q26. Find departments whose average employee age is greater than the overall average age.
SELECT dept_id
FROM employee_salary e1
JOIN employee_demographics e2
ON e1.employee_id = e2.employee_id
GROUP BY dept_id
HAVING AVG(age) >
(
    SELECT AVG(age)
    FROM employee_demographics
);
-- Q27. Find employees who earn the second-highest salary in the company.
select * from employee_salary
where salary=(
select distinct salary from employee_salary
order by salary desc
limit 1,1);
-- Q28. Find employees belonging to the department with the highest average salary.
select * from employee_salary e1
where dept_id= (
select dept_id from employee_salary
group by dept_id
order by avg(salary) desc
limit 1
);
-- Q29. Find employees whose salary is greater than the average salary of 
-- employees having the same gender.

SELECT *
FROM employee_salary e1
JOIN employee_demographics e2
    ON e1.employee_id = e2.employee_id
WHERE e1.salary >
(
    SELECT AVG(e3.salary)
    FROM employee_salary e3
    JOIN employee_demographics e4
        ON e3.employee_id = e4.employee_id
    WHERE e2.gender = e4.gender
);
-- Q30. Find departments that have more employees than every other department.

select * from employee_salary 
where dept_id in (
select dept_id from employee_salary
group by dept_id
having count(*) =
(select max(emp_count) from
(select count(*) as emp_count from employee_salary
group by dept_id 
)as dept_size));

