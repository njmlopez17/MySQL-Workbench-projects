#This is selecting value(s) to display from a table, using:
#     (a) String functions in MySQL

# --Query 01 (sampling of string function in MySQL)
SELECT LENGTH ('mississippi') AS 'Word Length';

# --Query 02 (sampling of string function in MySQL)
SELECT
	first_name, 
    LENGTH(first_name) AS Name_length_count
FROM
	parks_and_recreation.employee_demographics
ORDER BY 2
;
    
# --Query 03 (sampling of string function in MySQL)
SELECT UPPER ('mississippi') AS Word_case;
SELECT LOWER ('MISSISSIPPI') AS Word_case;

# --Query 04 (sampling of string function in MySQL)
SELECT
	first_name, 
    UPPER(first_name) AS Name_case
FROM
	parks_and_recreation.employee_demographics
ORDER BY 2
;

# --Query 05 (sampling of string function in MySQL)
SELECT TRIM('      space      ') AS Get_rid_of_spaces_from_both_side;
SELECT LTRIM('      space      ') AS Get_rid_of_spaces_from_left_side;
SELECT RTRIM('      space      ')  AS Get_rid_of_spaces_from_right_side;

# --Query 06 (sampling of string function in MySQL)
SELECT 
	first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 4)
FROM
	parks_and_recreation.employee_demographics
;

# --Query 07 (sampling of string function in MySQL)
SELECT 
	first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 4),
    SUBSTRING(first_name, 3,2),
    birth_date,
    SUBSTRING(birth_date,6,2) AS Birth_month
FROM
	parks_and_recreation.employee_demographics
;

# --Query 08 (sampling of string function in MySQL)
SELECT 
	first_name,
    REPLACE(first_name, 'a', 'ZZ')
FROM
	parks_and_recreation.employee_demographics
;

# --Query 09 (sampling of string function in MySQL)
SELECT LOCATE('e','Lopez');

SELECT 
	first_name,
    LOCATE('An', first_name)
FROM
	parks_and_recreation.employee_demographics
;

# --Query 10 (sampling of string function in MySQL)
SELECT 
	first_name,
    Last_name,
    CONCAT(last_name, ', ', first_name) AS Full_name
FROM
	parks_and_recreation.employee_demographics
;