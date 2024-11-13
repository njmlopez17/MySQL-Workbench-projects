#This is selecting all value(s) to display from a table, using:
#     (a) WHERE to filter the output
#     (b) GROUP BY and ORDER BY
#     (c) Aggregate functions (ie., AVG, MAX, MIN, COUNT)

# --Query 01 (sampling of group by)
SELECT 
	gender
FROM 
	employee_demographics
GROUP BY
	gender
;

# --Query 02 (sampling of group by with aggregate function)
SELECT 
	gender AS Gender, 
    AVG(age) AS Average_Age
FROM 
	employee_demographics
GROUP BY
	gender
;

# --Query 03 (sampling of group by with aggregate function)
SELECT 
	gender AS Gender, 
    AVG(age) AS Average_Age,
    MAX(age) AS Maximum_Age,
    MIN(age) AS Minimun_Age,
    COUNT(age) AS Number_of_People
FROM 
	employee_demographics
GROUP BY
	gender
;

# --Query 04 (sampling of order by)
SELECT 
	*
FROM 
	employee_demographics
ORDER BY
	first_name
;

# --Query 05 (sampling of order by)
SELECT 
	*
FROM 
	employee_demographics
ORDER BY
	first_name DESC
;

# --Query 06 (sampling of order by)
SELECT 
	*
FROM 
	employee_demographics
ORDER BY
	gender,
    age
;

# --Query 07 (sampling of order by)
SELECT 
	*
FROM 
	employee_demographics
ORDER BY
	gender,
    age DESC
;
