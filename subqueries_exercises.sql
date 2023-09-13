-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
-- 55 Total

USE employees;
SELECT * 
FROM employees
WHERE hire_date = (
		SELECT hire_date
        FROM employees 
        WHERE emp_no = '101010'
        )
AND emp_no IN (
		SELECT emp_no
        FROM dept_emp
        WHERE to_date > NOW()
        );

-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title, COUNT(*)
FROM titles
WHERE emp_no IN(
		SELECT emp_no
        FROM employees 
        WHERE first_name = 'Aamod'
        )
AND emp_no IN (
		SELECT emp_no
        FROM dept_emp
        WHERE to_date > NOW()
        )
GROUP BY title;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- 59,900

SELECT COUNT(*)
FROM employees 
WHERE emp_no NOT IN (
		SELECT emp_no
        FROM dept_emp
        WHERE to_date > NOW()
        );

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
-- Isamu Legleitner
-- Karsten Sigstam
-- Leon DasSama
-- Hilary Kambil

SELECT 
	e.first_name,
    e.last_name,
    e.gender
FROM (
	SELECT
		emp_no,
		first_name,
		last_name,
		gender
	FROM employees
    )e
WHERE
    e.gender = 'F'
AND e.emp_no IN (
	SELECT emp_no
    FROM dept_manager
    WHERE
		to_date > NOW()
	AND dept_no IN (
		SELECT dept_no
        FROM departments
        )
	);

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT
	e.first_name,
    e.last_name,
    (
    SELECT s.salary
    FROM salaries s
    WHERE
		s.emp_no = e.emp_no
	AND s.to_date = '9999-01-01'
    ) 
    AS Current_Salary, 
    (
		SELECT ROUND(AVG(se.salary),2)
        FROM
			salaries se
		)
        AS Historical_Average
	FROM employees e
    WHERE e.emp_no IN
    (
		SELECT s.emp_no
        FROM salaries s
        WHERE 
        s.to_date>NOW()
        AND s.salary>
        (
        SELECT 
			AVG(salary)
		FROM
			salaries
		)
	)
ORDER BY Current_salary;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

-- 83, 0.0346%

SELECT
    COUNT(*) AS num_salaries,
    COUNT(*) / (
        SELECT COUNT(*)
        FROM salaries
        WHERE
            to_date = '9999-01-01'
    ) * 100 AS percent_total_salaries
FROM salaries
WHERE
    to_date = '9999-01-01'
    AND salary BETWEEN (
        SELECT
            MAX(salary) - STDDEV(salary)
        FROM salaries
        WHERE
            to_date = '9999-01-01'
    )
    AND (
        SELECT
            MAX(salary) + STDDEV(salary)
        FROM salaries
        WHERE
            to_date = '9999-01-01'
    );

-- Bonus
-- Find all the department names that currently have female managers.

-- Find the first and last name of the employee with the highest salary.

-- Find the department name that the employee with the highest salary works in.

-- Who is the highest paid employee within each department.

