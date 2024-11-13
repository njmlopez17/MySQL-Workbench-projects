#This is selecting all value(s) to display from a table, using:
#     (a) WHERE to filter the output
#     (b) AND OR NOT logical operators
#     (c) LIKE condition + "%" and "_" wildcards

# --Query 01 (sampling of specific first name)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_salary
WHERE
	first_name = 'Leslie'
;

# --Query 02 (sampling of greater than)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_salary
WHERE
	salary > 50000
;

# --Query 03 (sampling of greater than or equal to)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_salary
WHERE
	salary >= 50000
;

# --Query 04 (sampling of less than)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_salary
WHERE
	salary < 50000
;

# --Query 05 (sampling of not equal to)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	gender != 'Female'
;

# --Query 06 (sampling of greater than)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	birth_date > '1985-01-01'
;

# --Query 07 (sampling of greater than + AND)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	birth_date > '1985-01-01'
AND
	gender = 'Male'
;

# --Query 08 (sampling of greater than + OR)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	birth_date > '1985-01-01'
OR
	gender = 'Male'
;

# --Query 09 (sampling of AND + OR, following the PEMDAS order/rule)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	(first_name = 'Leslie'
AND
	age = 44)
OR age > 55
;

# --Query 10 (sampling of LIKE condition, leveraging the wildcards)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	first_name LIKE 'Jer%'
;

# --Query 11 (sampling of LIKE condition, leveraging the wildcards)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	first_name LIKE '%om%'
;

# --Query 12 (sampling of LIKE condition, leveraging the wildcards)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	first_name LIKE '%o_%'
;

# --Query 13 (sampling of LIKE condition, leveraging the wildcards)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	first_name LIKE '%o_'
;

# --Query 14 (sampling of LIKE condition, leveraging the wildcards)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	birth_date LIKE '1989%'
;

# --Query 15 (sampling of LIKE condition, leveraging the wildcards)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	birth_date LIKE '197%'
;

