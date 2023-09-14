USE employees;

-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
-- table with no employee information

SELECT 
	emp_no,
    dept_no,
    from_date as start_date,
    to_date as end_date,
    IF (to_date>now(), 1,0) as is_current_employee
FROM dept_emp;

-- This table uses case statements 

SELECT
    de.emp_no,
    e.first_name,
    e.last_name,
    de.dept_no,
    de.from_date AS start_date,
    de.to_date AS end_date,
    CASE
		WHEN de.to_date = '9999-01-01' THEN 1
			ELSE 0
		END AS is_current_employee
	FROM dept_emp de
		JOIN employees e ON de.emp_no = e.emp_no;

-- This table uses IF statement

SELECT 
	de.emp_no,
	e.first_name,
    e.last_name,
    de.dept_no,
    de.from_date AS start_date,
    de.to_date AS end_date,
	IF ( de.to_date = '9999-01-01', True, False) AS is_current_employee
FROM dept_emp de
	JOIN employees e ON de.emp_no = e.emp_no;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT *,
	CASE 
		WHEN  last_name BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN last_name BETWEEN 'I' AND 'Q' THEN 'I-Q'
        ELSE 'R-Z'
    END AS alpha_group
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?

SELECT MIN(birth_date),MAX(birth_date)
FROM employees;

SELECT 
	COUNT(*) AS birth_by_decade,
    CASE 
		WHEN birth_date LIKE '195%' THEN '1950s'
        WHEN birth_date LIKE '196%' THEN '1960s'
        END AS Decade
	FROM employees
    GROUP BY Decade;

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT
    CASE
        WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE d.dept_name
    END AS merged_dep,
    AVG(s.salary) AS avg_salary
FROM departments d
    JOIN dept_emp de ON d.dept_no = de.dept_no
    JOIN salaries s ON de.emp_no = s.emp_no
WHERE 
    de.to_date = '9999-01-01'
    AND s.to_date = '9999-01-01'
GROUP BY merged_dep;


-- R&D 67.7k
-- Sales & Marketing 86.3k
-- Prod & QM 67.3k
-- Finance & HR 71.1k
-- Customer Service 67.2k


-- BONUS
-- Remove duplicate employees from exercise 1.

SELECT 
	de.emp_no,
    e.first_name,
    e.last_name,
    de.dept_no,
    de.from_date as start_date,
    de.to_date as end_date,
    IF (de.to_date= '9999-01-01',True,False) as is_current_employee
FROM ( 
	SELECT
		emp_no,
        dept_no,
        MAX(from_date) AS From_date,
        MAX(to_date) AS To_date
	FROM dept_emp
	GROUP BY
		emp_no,
		dept_no
    ) de
    JOIN employees e ON de.emp_no = e.emp_no
   ;

        
        
        