/*
	Trainity Data Analyst MySQL 
    Master Class 8 : Core Window Functions
*/

use companydb;

# Window Functions
-- A window function in MySQL is used to do calcultion across a set of rows that are related to the 
-- current row. The current row is the row for which function evaluation occurs.

SELECT 
    dno, AVG(salary) AS avg_sal
FROM
    employee
GROUP BY dno;

-- Using Window Function

select dno, avg(salary) over() as avg_salary, sum(salary) over() as sum_salary
from employee;

# WITH Example
with dept_avg as(
	SELECT 
    dno, AVG(salary) AS avg_sal
	FROM
		employee
	GROUP BY dno
)
select * from employee
inner join dept_avg
on employee.dno = dept_avg.dno;

# WITH example using Window Function
select 
	ssn, salary, dno,
	avg(salary) over(partition by dno) as avg_sal
from
employee;

select 
	ssn, salary, sex, dno,
	avg(salary) over(partition by dno) as avg_sal,
    sum(salary) over(partition by sex) as sum_sal
from
employee;

# Window functions are used in: -
-- Average Running price
-- Running Total orders
-- Running Sum Sales
-- Rank
-- Percentile

# Count number of employees in each department
select ssn, dno, sex, count(ssn) over(partition by dno, sex) as total_emp
from employee;

# RANK() Window Function
select 
	ssn, salary,
    rank() over(order by salary desc) as sal_rank
from employee;


select 
	ssn, salary, sex,
    rank() over(order by salary desc) as sal_rank,
    rank() over(partition by sex order by salary desc) as sex_sal_rank
from employee;

# DENSE_RANK() Window Function
select 
	ssn, salary, sex,
    dense_rank() over(order by salary desc) as sal_rank
from employee;

select 
	ssn, salary, sex,
    dense_rank() over(partition by sex order by salary desc) as sex_sal_rank
from employee;

# ROW_NUMBER() Window Function
select ssn, salary, sex,
row_number() over(partition by sex) as row_num
from employee;

select ssn, salary, sex,
row_number() over(partition by sex order by salary desc) as sex_salary_row_num
from employee;