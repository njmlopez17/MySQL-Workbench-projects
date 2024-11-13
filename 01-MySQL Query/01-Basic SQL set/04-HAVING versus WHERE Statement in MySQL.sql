#This is selecting all value(s) to display from a table, using:
#     (a) WHERE to filter the output
#     (b) HAVING to filter the output

# --Query 01 (sampling of where VS having)
SELECT 
	gender, 
    AVG(age) as AVERAGE_AGE
FROM 
	parks_and_recreation.employee_demographics
GROUP BY
	gender
HAVING
	AVG(age) > 40
;

# --Query 02 (sampling of where VS having)
SELECT 
	occupation, 
    AVG(salary) AS AVERAGE_SALARY
FROM 
	parks_and_recreation.employee_salary
WHERE
	occupation LIKE '%mana%'
GROUP BY
	occupation
;

# --Query 03 (sampling of where VS having)
SELECT 
	occupation, 
    AVG(salary) AS AVERAGE_SALARY
FROM 
	parks_and_recreation.employee_salary
WHERE
	occupation LIKE '%mana%'
GROUP BY
	occupation
HAVING AVG(salary) > 75000
;