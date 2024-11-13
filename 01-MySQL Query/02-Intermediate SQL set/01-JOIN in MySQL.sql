#This is selecting value(s) to display from a table, using:
#     (a) INNER JOIN in MySQL
#     (b) OUTER JOIN in MySQL
#     (c) SELF JOIN in MySQL
#     (d) JOIN multiple tables in MySQL

# --Query 01 (sampling of inner join in MySQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics 
INNER JOIN
	parks_and_recreation.employee_salary 
ON
	employee_demographics.employee_id = employee_salary.employee_id
;

# --Query 02 (sampling of inner join in MySQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics AS dem
INNER JOIN
	parks_and_recreation.employee_salary AS sal
ON
	dem.employee_id = sal.employee_id
;

# --Query 03 (sampling of inner join in MySQL)
SELECT 
	dem.employee_id AS ID, 
    age AS Age, 
    occupation AS Occupation, 
    sal.salary AS Salary
FROM
	parks_and_recreation.employee_demographics AS dem
INNER JOIN
	parks_and_recreation.employee_salary AS sal
ON
	dem.employee_id = sal.employee_id
;

# --Query 04 (sampling of outer join in MySQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics AS dem
LEFT OUTER JOIN
	parks_and_recreation.employee_salary AS sal
ON
	dem.employee_id = sal.employee_id
;

# --Query 05 (sampling of outer join in MySQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics AS dem
RIGHT OUTER JOIN
	parks_and_recreation.employee_salary AS sal
ON
	dem.employee_id = sal.employee_id
;

# --Query 06 (sampling of self join in MySQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_salary AS emp1
JOIN
	parks_and_recreation.employee_salary AS emp2
ON
	emp1.employee_id + 1 = emp2.employee_id
;

# --Query 07 (sampling of self join in MySQL)
SELECT 
	emp1.employee_id AS Emp_Santa_ID,
    emp1.first_name AS First_Name_Santa,
    emp1.last_name AS Last_Name_Santa,
	emp2.employee_id AS Emp_ID,
    emp2.first_name AS First_Name,
    emp2.last_name AS Last_Name
FROM
	parks_and_recreation.employee_salary AS emp1
JOIN
	parks_and_recreation.employee_salary AS emp2
ON
	emp1.employee_id + 1 = emp2.employee_id
;

# --Query 08 (sampling of joining multiple tables in MySQL)
SELECT
	*
FROM
	parks_and_recreation.employee_demographics AS dem
INNER JOIN
	parks_and_recreation.employee_salary AS sal
ON
	dem.employee_id = sal.employee_id
INNER JOIN
	parks_and_recreation.parks_departments AS dept
ON
	sal.dept_id = dept.department_id
;

# --Query 09 (sampling of joining multiple tables in MySQL)
SELECT
	dem.first_name AS First_Name,
    dem.last_name AS Last_Name,
    dept.department_name AS Is_In_Department_Of
FROM
	parks_and_recreation.employee_demographics AS dem
INNER JOIN
	parks_and_recreation.employee_salary AS sal
ON
	dem.employee_id = sal.employee_id
INNER JOIN
	parks_and_recreation.parks_departments AS dept
ON
	sal.dept_id = dept.department_id
;
    