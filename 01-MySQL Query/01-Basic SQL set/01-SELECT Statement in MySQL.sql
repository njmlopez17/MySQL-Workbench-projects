#This is selecting all value(s) to display from a table
# --Query 01
SELECT 
	* 
FROM 
	parks_and_recreation.employee_demographics
;

#This is selecting specific column value(s) to display from a table
# --Query 01
SELECT 
	first_name 
FROM 
	parks_and_recreation.employee_demographics
    ;
# --Query 02
SELECT 
	first_name, 
	last_name, 
	birth_date
FROM 
	parks_and_recreation.employee_demographics
;

#This is selecting specific column value(s) to display from a table, with calculation (that follows the PEMDAS order/rule)
# --Query 01
SELECT 
	first_name, 
	age,
	(age + 10) * 10 + 10
FROM 
	parks_and_recreation.employee_demographics
;

#This is selecting specific and distinct column value(s) to display from a table
# --Query 01
SELECT DISTINCT 
	gender 
FROM 
	parks_and_recreation.employee_demographics
;
# --Query 02
SELECT DISTINCT 
	first_name, 
	gender 
FROM 
	parks_and_recreation.employee_demographics
;