/*
	Trainity Data Analyst MySQL Master Class 4
    Data Normalization and Joins
*/
use companydb;

# Use of Aliases

select sum(salary) as sum_of_salaries_of_all_employees from employee;

select sum(salary) as Total_salary, dno as Department_number from employee
group by dno;

-- Joins
-- Inner Join -> Returns records that have matching values in both tables
-- Left Join -> Returns all records from the left table, and the matched records from the right table
-- Right Join -> Returns all records from the right table, and the matched records from the left table
-- Cross Join -> Returns all records from both tables

# Inner Join
select * from employee;

select * from works_on;

select * from works_on 
inner join employee
on works_on.essn = employee.ssn;

# Left Join
select * from employee
left join department
on employee.dno = department.dnumber;

select fname, lname, dname from employee
left join department
on employee.dno = department.dnumber;

# Right Join
select fname, lname, dname from employee
right join department
on employee.dno = department.dnumber;

select * from employee
right join department
on employee.dno = department.dnumber;

# Cross Join

select * from department;

select * from project;

select * from project 
cross join department;

# Joins and filtering
select * from employee
inner join department
on employee.dno = department.dnumber
where dnumber = 5 and salary > 40000;





