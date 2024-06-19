/* Trainity MySQL Master Class_1
*/

create database companydb;

use companydb;

create table employee(
  fname varchar(30),
  minit char(1),
  lname varchar(30),
  ssn char(9),
  bdate date,
  address varchar(30),
  sex char(1),
  salary float(10, 2),
  super_ssn char(9),
  dno smallint(6),
  constraint pk_employee PRIMARY KEY (ssn)
);


create table department(
  dname varchar(30),
  dnumber smallint primary key,
  mgr_ssn char(9),
  mgr_start_date date
);

create table dept_locations(
  dnumber smallint,
  dlocation varchar(20),
  constraint composite_pk_dept_loc PRIMARY KEY (dnumber, dlocation)
);

create table project(
  pname varchar(30),
  pnumber smallint,
  plocation varchar(30),
  dnum smallint,
  constraint pk_project PRIMARY KEY (pnumber)
);

create table works_on(
  essn char(9),
  pno smallint,
  hours float(4, 2),
  constraint pk_works_on PRIMARY KEY (essn, pno)
);

create table dependent(
  essn char(9),
  dependent_name varchar(30),
  sex char(1),
  bdate date,
  relationship varchar(20),
  constraint pk_dependent PRIMARY KEY (essn, dependent_name)
);



insert into employee(
    fname,
    minit,
    lname,
    ssn,
    bdate,
    address,
    sex,
    salary,
    super_ssn,
    dno
  )
VALUES
  (
    'John',
    'B',
    'Smith',
    '123456789',
    '1965-01-09',
    '731 Fondren, Houston, TX',
    'M',
    30000,
    '333445555',
    5
  ),
  (
    'Franklin',
    'T',
    'Wong',
    '333445555',
    '1955-01-09',
    '638 Fondren, Houston, TX',
    'M',
    40000,
    '888665555',
    5
  ),
  (
    'Alicia',
    'J',
    'Zelaya',
    '999887777',
    '1968-01-09',
    '3321 Fondren, Houston, TX',
    'F',
    25000,
    '987654321',
    4
  ),
  (
    'Jennifer',
    'S',
    'Wallace',
    '987654321',
    '1941-01-09',
    '21 Fondren, Houston, TX',
    'F',
    43000,
    '888665555',
    4
  ),
  (
    'Ramesh',
    'K',
    'Narayan',
    '666884444',
    '1962-01-09',
    '975 Fondren, Houston, TX',
    'M',
    38000,
    '333445555',
    5
  ),
  (
    'Joyce',
    'A',
    'English',
    '453453453',
    '1972-01-09',
    '5631 Fondren, Houston, TX',
    'F',
    25000,
    '333445555',
    5
  ),
  (
    'Ahmad',
    'V',
    'Jabbar',
    '987987987',
    '1969-01-09',
    '980 Fondren, Houston, TX',
    'M',
    25000,
    '987654321',
    4
  ),
  (
    'James',
    'E',
    'Borg',
    '888665555',
    '1937-01-09',
    '450 Fondren, Houston, TX',
    'M',
    55000,
    NULL,
    1
  );

select * from employee;

insert into department(dname, dnumber, mgr_ssn, mgr_start_date)
VALUES
  ('Research', 5, 333445555, '1988-05-22'),
  ('Administration', 4, 987654321, '1995-05-22'),
  ('Headquarters', 1, 888665555, '1981-05-22');

insert into dept_locations(dnumber, dlocation)
values
  (1, 'Houston'),
  (4, 'Stafford'),
  (5, 'Bellaire'),
  (5, 'Sugarland'),
  (5, 'Houston');

insert into works_on (essn, pno, hours)
values
  ('123456789', 1, 32.5),
  ('123456789', 2, 7.5),
  ('666884444', 3, 40.0),
  ('453453453', 1, 20.0),
  ('453453453', 2, 20.0),
  ('333445555', 2, 10.0),
  ('333445555', 3, 10.0),
  ('333445555', 10, 10.0),
  ('333445555', 20, 10.0),
  ('999887777', 30, 30.0),
  ('999887777', 10, 10.0),
  ('987987987', 10, 35.0),
  ('987987987', 30, 5.0),
  ('987654321', 30, 20.0),
  ('987654321', 20, 15.0),
  ('888665555', 20, NULL);

insert into project(pname, pnumber, plocation, dnum)
values
  ('ProductX', 1, 'Bellaire', 5),
  ('ProductY', 2, 'Sugarland', 5),
  ('ProductZ', 3, 'Houston', 5),
  ('Computerization', 10, 'Stafford', 4),
  ('Reorganization', 20, 'Houston', 1),
  ('Newbenefits', 30, 'Stafford', 4);

insert into dependent(essn, dependent_name, sex, bdate, relationship)
values
  (
    '333445555',
    'Alice',
    'F',
    '1986-04-05',
    'Daughter'
  ),
  (
    '333445555',
    'Theodore',
    'M',
    '1983-04-05',
    'Son'
  ),
  ('333445555', 'Joy', 'F', '1958-04-05', 'Spouse'),
  (
    '987654321',
    'Abner',
    'M',
    '1942-04-05',
    'Spouse'
  ),
  ('123456789', 'Michael', 'M', '1988-04-05', 'Son'),
  (
    '123456789',
    'Alice',
    'M',
    '1988-04-05',
    'Daughter'
  ),
  (
    '123456789',
    'Elizabeth',
    'M',
    '1967-04-05',
    'Spouse'
  );


alter table employee
add
  constraint fk_super_ssn FOREIGN KEY (super_ssn) REFERENCES employee(ssn);

alter table employee
add
  constraint fk_dno FOREIGN KEY (dno) REFERENCES department(dnumber);

alter table dept_locations
add
  constraint fk_dnumber FOREIGN KEY (dnumber) REFERENCES department(dnumber);

alter table project
add
  constraint fk_dnum FOREIGN KEY (dnum) REFERENCES department(dnumber);

alter table works_on
add
  constraint fk_essn FOREIGN KEY (essn) REFERENCES employee(ssn);

alter table works_on
add
  constraint fk_pno FOREIGN KEY (pno) REFERENCES project(pnumber);

alter table dependent
add
  constraint fk_dep_essn FOREIGN KEY (essn) REFERENCES employee(ssn);
  
select * from employee;

select * from dept_locations;

select * from project;

select * from works_on;

select * from dependent;