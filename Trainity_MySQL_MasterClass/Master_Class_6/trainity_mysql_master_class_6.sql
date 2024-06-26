/*
	Trainity Data Analyst MySQL Master Class 6
    MySQL Subqueries
*/
-- Nested query in another SQL query is called as Subquery
-- Subqueries allow to answer more complex questions

use companydb;

select * from employee;

# Print details of all the managers from the employee table
# Placement -> nested subquery
select ssn,fname,lname, dno
from employee 
where ssn in
(select distinct super_ssn from employee 
 where super_ssn is not null);
 
 # Print details of employees who are working on a project
 select ssn, fname, lname 
 from employee
 where ssn in (
 select distinct essn from works_on
 where essn is not null);
 
 # Placement -> Inline subquery
 # Print max and min avg salaries across all departments
 
 select min(Dept_avg.avg_salary), max(Dept_avg.avg_salary)
 from 
 (select avg(salary) as avg_salary, dno
 from employee
 group by dno) as Dept_avg;
 
 # Placement -> Scalar Query
 # Print all employees who are earning more than the avg salary acrossa all employees
 
 select ssn,fname,lname, salary
 from employee
 where salary > 
 (select avg(salary) as avg_salary from employee);

# Common Table Expressions (CTE)
# Print Name, department, total hours that employee each has worked
# Placement -> With
with employee_hours as 
(select essn, sum(hours) as total_hours
from works_on
group by essn)
select ssn, fname, dno, total_hours
from employee
inner join employee_hours
on employee.ssn = employee_hours.essn;


with employee_hours as (
select essn, sum(hours) as total_hours
from works_on 
group by essn
), 
dno_avg_salary as (
select dno, avg(salary) as avg_salary
from employee
group by dno
)
select * from dno_avg_salary
inner join (
	select ssn, fname, dno, total_hours
	from employee
	inner join employee_hours
	on employee.ssn = employee_hours.essn
) as inner_query
on dno_avg_salary.dno = inner_query.dno;