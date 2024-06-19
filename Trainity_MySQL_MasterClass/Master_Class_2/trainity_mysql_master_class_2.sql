/* Trainity MySQL Master_Class_2
*/
# Statements, Tables and Data Definition Language(DDL) commands

create database if not exists trainity_sql_master_class_2;

use trainity_sql_master_class_2;

show databases;

# Create a table
create table students(
	roll_no bigint primary key,
    `name` varchar(20),
    age int,
    gender char(1),
    hobbies varchar(50)
);

# Truncate table --> deletes only the data in the table
truncate students;

# Drop table --> deletes columns as well as data in those columns
drop table students;

# Adding new column 
alter table students
add column hometown varchar(10) after age;

# Adding two or more columns
alter table students
add column(
	emergency_contact varchar(20),
    address varchar(50)
);

# Changing column datatype
alter table students
modify address varchar(220);

# Renaming a column
alter table students
change column gender sex char(1);

# Renaming a table
alter table students
rename to students_data;