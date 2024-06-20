/*
	Trainity Master Class_ 3 : DML and DDL commands
    
    SELECT, INSERT, UPDATE, DELETE
*/

use companydb;

# SELECT:-
 
## Filter selected columns from a table
select fname, lname from employee;

## Filter all columns from a table
select * from employee;

## conditional select - WHERE
select fname, lname, sex from employee
where sex = 'M';

## Multiple conditions with AND, OR keywords
select fname, lname, dno, sex from employee
where sex = 'M' and dno = 5;

select fname, lname, dno, sex from employee
where sex = 'M' or dno = 5;

## Operators (>, >=, <, <=, etc.)
select * from employee
where salary >= 30000 and sex='M';

select * from employee
where salary >= 30000 and sex <> 'M';

## Use of WILDCARDS and LIKE operators
### ('_') -> One character only
### ('%') -> Any number of characters
select fname, lname from employee
where fname like "J___";

select fname, lname, address from employee
where address like '%Houston%';


## Using IN, NOT IN, NULL and NOT NULL
select pname, plocation from project 
where plocation in ('Houston','Stafford','Bellaire');

select pname, plocation from project 
where plocation not in ('Houston','Stafford');

## Using BETWEEN
select fname, ssn, salary from employee
where salary between 20000 and 40000;

## Using ORDER BY
select fname, salary from employee
order by salary desc;

select fname, salary,sex from employee
where sex = 'M'
order by salary desc;

# INSERT: - 
insert into employee(fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno)
values('Advait','P','Chavan',987654312,'2001-05-03','B303,Mumbai,IN','M',95000.00,'123456789',5);

select * from employee;

# SELECT(Cont...)
## NULL
select fname,ssn, super_ssn from employee
where super_ssn is null;

## NOT NULL
select fname,ssn, super_ssn from employee
where super_ssn is not null;

# UPDATE
update employee
set super_ssn = 333445555
where super_ssn is null;

select * from employee;

# DELETE
delete from employee
where minit = 'P';


