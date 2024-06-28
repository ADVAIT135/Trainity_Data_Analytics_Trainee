/*
	Trainity Data Analyst MySQL 
    Master Class 10 : Data Cleaning Strategy
*/

use companydb;

# Data Cleaning -> task of cleaning raw data to make it usable and ready for analysis

# Normalization -> Standardizing or CLeaning Up a column by transforming it in some way to make it ready for analysis
-- Adjusting column that includes multiple currenceis to one common currency
-- Adjusting the varied distribution of a column value by transforming it into a Z-Score
-- Converting all price into a common metric (eg: Price per ounce)

# Steps during data-cleaning task: -
-- What data do you need? -> Review the problem you are solving.
-- What data do you have? -> Understand the data types across the dataset.
-- How will you clean data? -> Manipulate an existing column or create new ones.
-- How will you analyze? 

# Methods to cover
-- Parsing Information
-- Returning where information lives
-- Changing the data type of the information

# LEFT() Function - extracts a number of characters from a string (left -> right)
select left("HR-001", 2) as dept_id;
select left("MK-005", 2) as dept_id;

select address, left(address, 4) as address_cnt
from employee;

# RIGHT() Function - extracts a number of characters from a string (right -> left)
select right("HR-001", 3) as dept_id;
select right("MK-005", 3) as dept_id;

select address, right(address, 2) as country_code
from employee;

# SUBSTR() - extracts a substring from a string(from any position)
select address, substr(address, 2, 5) as substring_address
from employee;

select address, substr(address from 2 for 5) as substring_addr
from employee;

# CONCAT() - adds two or more expression together
select fname, lname, concat(fname, ' ', lname) as full_name
from employee;


# CAST() - converts a value (of any type) into the specified datatype
select cast("1970-01-29" as date);

# POSITION() - returns the position of the first occurence of a substring in a string
select address, position("Houston" in address) as houston_position
from employee;

select address, position("on" in address) as on_position
from employee;

# COALESCE() - returns the first non-null value in a list
select coalesce(null, null, 351, 'advait') as c_1;

select coalesce(salary) from employee;

select coalesce(null, null, "string") as c_2;


