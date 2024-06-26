/*
	Trainity Data Analyst MySQL Master Class 7
    Subqueries Formatting
*/

use companydb;

# Subqueries Dependencies 
# -> Simple Subquery -- Independent of the larger subquery
# -> Correlated Subquery -- The inner subquery is dependent on the larger query

# COORELATED SUBQUERY
# Print all employees who are earning more than their department average salary

SELECT 
    ssn, fname, salary, dno
FROM
    employee AS outer_table
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employee
        WHERE
            dno = outer_table.dno
        GROUP BY dno); 
        
# Print all employees who have teammates
SELECT 
    ssn, fname, lname, dno, super_ssn
FROM
    employee AS outer_table
WHERE
    EXISTS( SELECT 
            'X'
        FROM
            employee
        WHERE
            ssn = outer_table.super_ssn);
            
# VIEWS in MySQL
# Views are tables which are created for a particular active session, but are not stored on the database 
CREATE VIEW male_employee_view AS
    (SELECT 
        *
    FROM
        employee
    WHERE
        sex = 'M');

select * from male_employee_view;


SELECT 
    AVG(salary)
FROM
    male_employee_view;

SELECT 
    *
FROM
    male_employee_view
        INNER JOIN
    department ON male_employee_view.dno = department.dnumber;
    
CREATE VIEW dept_sal_avg AS
    (SELECT 
        dno, AVG(salary) AS avg_sal
    FROM
        employee
    GROUP BY dno);
    
select * from dept_sal_avg;


SELECT 
    *
FROM
    employee
        INNER JOIN
    dept_sal_avg ON employee.dno = dept_sal_avg.dno
WHERE
    employee.salary > dept_sal_avg.avg_sal;
    
# Subqueries Tradeoffs: - 
# A. Readability -> Easy to determine what the code does
# B. Performance -> How quickly a code runs/executes
# C. Query Plan -> What happens under the hood

# Subquery optimization (Execution speed is much faster)
SELECT 
    *
FROM
    employee
        INNER JOIN
    dept_sal_avg ON employee.dno = dept_sal_avg.dno
        AND employee.salary > dept_sal_avg.avg_sal;