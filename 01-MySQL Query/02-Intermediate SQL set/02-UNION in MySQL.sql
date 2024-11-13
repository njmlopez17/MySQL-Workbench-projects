#This is selecting value(s) to display from a table, using:
#     (a) UNION in MySQL

# --Query 01 (sampling of union in MySQL)
SELECT 
	first_name,
    last_name
FROM
	employee_demographics
UNION # by default, this is UNION DISTINCT
SELECT
	first_name,
    last_name
FROM
    employee_salary
;

# --Query 02 (sampling of union in MySQL)
SELECT 
	first_name, 
    last_name, 'from demographics table' AS Tag
FROM
	employee_demographics
UNION ALL
SELECT
	first_name,
    last_name, 'from salary table' AS Tag
FROM
    employee_salary
;

# --Query 03 (sampling of union in MySQL)
# Scenario is list of employee that is equal or more than 50 yrs old or got a salary of more than 70k
SELECT 
	dem.first_name, 
    dem.last_name, 'Employee in 50s' AS Remarks
FROM
	employee_demographics as dem
WHERE
	age >= 50
UNION 
SELECT
	sal.first_name,
    sal.last_name, 'With high salary' AS Remarks
FROM
    employee_salary as sal
WHERE
	salary > 70000
;

# --Query 04 (sampling of union in MySQL)
# Scenario is list of employee that is more than 40 yrs old (and their respective gender) or got a salary of more than 70k
SELECT 
	dem.first_name, 
    dem.last_name, 'Employee in 40s and Male' AS Remarks
FROM
	employee_demographics as dem
WHERE
	age > 40
AND
	gender = 'Male'
UNION 
SELECT 
	dem.first_name, 
    dem.last_name, 'Employee in 40s and Female' AS Remarks
FROM
	employee_demographics as dem
WHERE
	age > 40
AND
	gender = 'Female'
UNION
SELECT
	sal.first_name,
    sal.last_name, 'With high salary' AS Remarks
FROM
    employee_salary as sal
WHERE
	salary > 70000
ORDER BY
	first_name,
    last_name
;