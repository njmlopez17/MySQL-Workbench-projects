#This is selecting all value(s) to display from a table, using:
#     (a) Limit in SQL
#     (b) Aliasing in SQL

# --Query 01 (sampling of limit in SQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics
LIMIT 3
;

# --Query 02 (sampling of limit in SQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics
ORDER BY
	age DESC
LIMIT 3
;

# --Query 03 (sampling of limit in SQL)
SELECT 
	*
FROM
	parks_and_recreation.employee_demographics
ORDER BY
	age DESC
LIMIT 2, 1
;

# --Query 04 (sampling of aliasing in SQL)
SELECT 
	gender,
    AVG(age) AS AVERAGE_AGE
FROM
	parks_and_recreation.employee_demographics
GROUP BY
	gender
HAVING AVERAGE_AGE > 40
;