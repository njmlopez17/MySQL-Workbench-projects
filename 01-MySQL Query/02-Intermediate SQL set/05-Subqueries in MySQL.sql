#This is selecting value(s) to display from a table, using:
#     (a) Subqueries in MySQL

# --Query 01 (sampling of subquery in MySQL)
# Scenario is only display employees that works for Parks and Recreation department (at WHERE level)
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
WHERE
	employee_id IN (
		SELECT 
			employee_id
        FROM
			employee_salary
		WHERE
			dept_id = 1
    )
;

# --Query 02 (sampling of subquery in MySQL)
# Scenario is to compare individual employee salary to the total average salary (at SELECT level)
SELECT 
	CONCAT(last_name, ', ', first_name) AS 'Full Name',
    salary AS 'Employee Salary',
		(SELECT 
			AVG(salary) 
        FROM
			employee_salary 
        ) AS 'Total Average Salary'
FROM
	employee_salary
;

# --Query 03 (sampling of subquery in MySQL)
# Scenario is to get average age, maximum age, minimun age, and total count by gender
# Then get average maximum age, average minimun age (at FROM level)
SELECT 
	gender AS 'Gender', 
    AVG(age) AS 'Average Age', 
    MAX(age) AS 'Maximum Age', 
    MIN(age) AS 'Minimum Age', 
    COUNT(age) AS 'Total by gender'
FROM 
	parks_and_recreation.employee_demographics
GROUP BY
	gender
;
# Leveraging the above query...
SELECT
	gender,
    Average_Age,
    AVG(Maximum_Age) AS 'Average Max Age',
    AVG(Minimum_Age) AS 'Average Min Age',
    Total_by_gender
FROM (
	SELECT 
		gender AS 'Gender', 
		AVG(age) AS 'Average_Age', 
		MAX(age) AS 'Maximum_Age', 
		MIN(age) AS 'Minimum_Age', 
		COUNT(age) AS 'Total_by_gender'
	FROM 
		parks_and_recreation.employee_demographics
	GROUP BY gender
	) AS Temp_Table
GROUP BY gender
;
	