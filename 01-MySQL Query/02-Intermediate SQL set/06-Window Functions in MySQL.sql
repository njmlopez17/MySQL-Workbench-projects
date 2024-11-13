#This is selecting value(s) to display from a table, using:
#     (a) Window Function in MySQL

# --Query 01 (sampling of window function in MySQL)
# Query using GROUP BY (aggregate function of AVERAGE)
SELECT 
	gender, 
    AVG(salary) AS 'Average salary by gender'
FROM 
	parks_and_recreation.employee_demographics AS dem
JOIN
	parks_and_recreation.employee_salary AS sal
	ON
		dem.employee_id = sal.employee_id
GROUP BY gender
;
# Query using WINDOW FUNCTION (aggregate function of AVERAGE)
SELECT 
	CONCAT(dem.last_name, ', ', dem.first_name) AS 'Full Name',
    gender AS 'Gender', 
    AVG(salary) OVER(PARTITION BY gender) AS 'Average salary'
FROM 
	parks_and_recreation.employee_demographics AS dem
JOIN
	parks_and_recreation.employee_salary AS sal
	ON
		dem.employee_id = sal.employee_id
;

# --Query 02 (sampling of window function in MySQL)
# Query using WINDOW FUNCTION (aggregate function of SUM)
SELECT 
	CONCAT(dem.last_name, ', ', dem.first_name) AS 'Full Name',
    gender AS 'Gender', 
    SUM(salary) OVER(PARTITION BY gender) AS 'Average salary'
FROM 
	parks_and_recreation.employee_demographics AS dem
JOIN
	parks_and_recreation.employee_salary AS sal
	ON
		dem.employee_id = sal.employee_id
;

# --Query 03 (sampling of window function in MySQL)
# Query using WINDOW FUNCTION (rolling total)
SELECT 
	CONCAT(dem.last_name, ', ', dem.first_name) AS 'Full Name',
    gender AS 'Gender', 
    salary AS 'Salary',
    SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS 'Rolling Total'
FROM 
	parks_and_recreation.employee_demographics AS dem
JOIN
	parks_and_recreation.employee_salary AS sal
	ON
		dem.employee_id = sal.employee_id
;

# --Query 04 (sampling of window function in MySQL)
# Query using WINDOW FUNCTION (ROW NUMBER, RANK, and DENSE RANK)
SELECT 
	dem.employee_id,
	CONCAT(dem.last_name, ', ', dem.first_name) AS 'Full Name',
    gender AS 'Gender', 
    salary AS 'Salary',
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS 'Row Number', # will give unique number per row (sort of ranking)
    RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS 'Ranking by Gender (positional)', # will give actual rank per row, where ranking is positionally
	DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS 'Ranking by Gender (numerical)' # will give actual rank per row, where ranking is numerically
FROM 
	parks_and_recreation.employee_demographics AS dem
JOIN
	parks_and_recreation.employee_salary AS sal
	ON
		dem.employee_id = sal.employee_id
;