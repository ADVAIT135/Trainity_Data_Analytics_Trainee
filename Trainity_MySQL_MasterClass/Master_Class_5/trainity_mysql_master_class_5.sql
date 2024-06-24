/*
	Trainity Data Analyst MySQL
    Master Class 5 : NULLS and Aggregation
*/

use companydb;

# Count Function

select * from employee;

select count(*) from employee;

select count(super_ssn) from employee;

select count(*) - count(super_ssn) as Count_Null_Super_SSN
from employee;

# SUM Function

select sum(salary) from employee; 

select sum(salary) from employee
where sex = 'F'; 

# MIN MAX Function
select min(salary) as Min_Salary, max(salary) as Max_Salary
from employee
where sex = 'M';

# AVERAGE FUNCTION / MEAN FUNCTION
select avg(salary) as Average_salary
from employee;

select sum(salary)/count(salary) as avg_salary
from employee;

# GROUP BY Clause

select sex, avg(salary) as avg_emp_salary
from employee
group by sex;

select essn, sum(hours) as total_emp_work_hours
from works_on
group by essn;

# Calculate Avg salary for Male employee for each department
select dno, sex, avg(salary) as avg_salary
from employee
where sex = 'M'
group by dno;

# FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY

select dno, sex, avg(salary) as avg_salary
from employee
where sex = 'M'
group by dno
order by avg_salary desc;

# Calculate avg salary for each department and gender

select dno, sex, avg(salary)
from employee
group by dno, sex;

# Print all the unique manager ids
select distinct super_ssn from employee;

select distinct sex, super_ssn from employee;

# Count all the unique manager ids
select count(distinct super_ssn) from employee;

# HAVING CLAUSE
# Calculate average salary of department with average salary more than 32000

# FROM -> GROUP BY -> HAVING ->  SELECT -> ORDER BY

select dno, avg(salary)
from employee
group by dno
having avg(salary) > 32000;  

# DATE Functions
# EXTRACT Function
select extract(year from bdate) as Year_of_Birth
from employee;

select count(*), extract(year from bdate) as Year_of_Birth
from employee
group by Year_of_Birth;

select count(*), extract(year from bdate) as Year_of_Birth, extract(month from bdate) as Month_of_Birth
from employee
group by Year_of_Birth, Month_of_Birth;

select avg(salary) from employee;

# CASE Expression
select ssn,salary,
	case 
		when salary < 41777.777778
			then "Less"
		when salary = 41777.777778
			then "Equal"
		else "More"
        end as pay_scale
from employee;
 