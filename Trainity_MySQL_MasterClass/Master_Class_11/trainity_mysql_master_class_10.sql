/*
	Trainity Data Analyst MySQL
    Master Class 11 : Advanced MySQL and Performance tunning
*/

use companydb;

# FULL OUTER JOIN -> returns all records when there is a match in left(table1) or right(table2) table records.
# NON EQUI JOIN -> uses comparision operator instead of the equal sign like <,>, <=, >= along with conditions.

-- list all pair of employees having the same department

SELECT 
    left_table.ssn AS left_ssn,
    right_table.ssn AS right_ssn,
    left_table.dno AS left_dno,
    right_table.dno AS right_dno
FROM
    employee AS left_table
        JOIN
    employee AS right_table ON left_table.dno = right_table.dno
        AND left_table.ssn <> right_table.ssn;
        
        
SELECT 
    left_table.ssn AS left_ssn,
    right_table.ssn AS right_ssn,
    left_table.dno AS left_dno,
    right_table.dno AS right_dno
FROM
    employee AS left_table
        JOIN
    employee AS right_table ON left_table.dno = right_table.dno
        AND left_table.ssn < right_table.ssn;

# SELF JOINS - A table is joined with itself
-- print employee name and manager name

SELECT 
    CONCAT(left_table.fname, ' ', left_table.lname) AS employee_name,
    CONCAT(right_table.fname,
            ' ',
            right_table.lname) AS manager_name
FROM
    employee left_table
        LEFT JOIN
    employee right_table ON left_table.super_ssn = right_table.ssn;
    
# UNION Operator -> used to combine the result set of two or more SELECT statements.

SELECT 
    dno, sex, AVG(salary)
FROM
    employee
WHERE
    sex = 'M'
GROUP BY dno 
UNION SELECT 
    dno, sex, AVG(salary)
FROM
    employee
WHERE
    sex = 'F'
GROUP BY dno;

# FULL OUTER JOIN -> returns all records when there is a match in left(table1) or right(table2) table records.

select * from employee
left join department
on employee.dno = department.dnumber
union
select * from employee
right join department
on employee.dno = department.dnumber;

# Explain Utility
explain select * from employee
left join department
on employee.dno = department.dnumber
union
select * from employee
right join department
on employee.dno = department.dnumber;