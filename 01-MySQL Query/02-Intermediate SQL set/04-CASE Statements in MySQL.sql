#This is selecting value(s) to display from a table, using:
#     (a) CASE statements in MySQL

# --Query 01 (sampling of case statement in MySQL)
# Scenario is list of employee grouped by age criteria
SELECT
	first_name,
    last_name,
    age,
CASE
	WHEN age <=40 THEN 'YOUNG' 
    WHEN age BETWEEN 41 AND 50 THEN 'YOUNG AT HEART'
    WHEN age >= 51 THEN 'OLD'
END AS 'Age Criteria'
FROM
	parks_and_recreation.employee_demographics
;

# --Query 02 (sampling of case statement in MySQL)
# Scenario is list of employee grouped by their respective pay increase and bonus
# Requirements:
	# (a) < 50000 gets a 5% bonus, 
    # (b) > 50000 gets a 7% bonus, and 
    # (c) any who is in Finace gets an extra 10% bonus
SELECT
	first_name,
    last_name,
    salary,
 CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05) 
	WHEN salary > 50000 THEN salary + (salary * 0.07) 
END AS 'New Salary',
CASE
	WHEN dept_id = 6 THEN salary * 0.10 # this is for folks in the Finance Dept
END AS 'New Salary (Finance Group)'
FROM
	parks_and_recreation.employee_salary
;