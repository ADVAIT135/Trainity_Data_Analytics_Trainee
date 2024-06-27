/*
	Trainity Data Analyst MySQL Master Class 9
    Aliases for Multiple Window Functions
*/

use companydb;

# Aliases
# Column Alias

SELECT 
    ssn, CONCAT(fname, ' ', lname) AS Full_name
FROM
    employee;
    
    
SELECT 
    ssn, CONCAT(fname, ' ', lname) AS Full_name,
    avg(salary) over(partition by dno) AS avg_dept_salary
FROM
    employee;
    
# Table Alias

SELECT 
    ssn, salary, employee.dno, avg_salary
FROM
    employee
        INNER JOIN
    (SELECT 
        dno, AVG(salary) AS avg_salary
    FROM
        employee
    GROUP BY dno) AS dept_avg_sal ON employee.dno = dept_avg_sal.dno
        AND employee.salary > dept_avg_sal.avg_salary;

# LAG() Window Function
# LAG() -> Comparing a row to a previous row
select ssn, fname, salary, lag(salary,1) over(order by salary) as prev_salary
from employee;

select ssn, fname, salary, lag(salary,1,0) over(order by salary) as prev_salary
from employee;

select ssn, fname, dno, salary,
	lag(salary,1, 0) over(order by salary) as prev_salary,
    lag(salary,1,0) over (partition by dno order by salary) as dept_prev_sal
from employee;

select ssn, fname, salary, salary - lag(salary, 1) over(order by salary) as diff_salary
from employee;

# LEAD() Window Function
# LEAD() -> Comparing a row to next row
select ssn, fname, salary, salary - lead(salary, 1) over(order by salary desc) as diff_salary
from employee;

# PERCENTILES
select ssn, salary, percent_rank() over(order by salary) as percent_sal
from employee;

select ssn, salary, round(percent_rank() over(order by salary),2) as percent_sal
from employee;

select ssn, salary, sex, round(percent_rank() over(partition by sex order by salary),2) as percent_sal
from employee;