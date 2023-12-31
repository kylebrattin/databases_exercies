-- 1.Use the join_example_db. Select all the records from both the users and roles tables

USE join_example_db;
SELECT * FROM users
JOIN roles
ON users.role_id = roles.id;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT * FROM users
JOIN roles
ON users.role_id = roles.id; -- No nulls

SELECT * FROM users
LEFT JOIN roles
ON users.role_id = roles.id; -- Right side has nulls

SELECT * FROM users
RIGHT JOIN roles
ON  users.role_id = roles.id; -- Left side has nulls


-- 3.Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name, COUNT(users.id) AS 'Number of Users' FROM users
JOIN roles
ON users.role_id = roles.id
GROUP BY roles.id;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

USE employees;
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name,'',e.last_name) AS Department_Manager
FROM departments as d
JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
JOIN employees AS e 
ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'
ORDER BY Department_Name;

-- 3. Find the name of all departments currently managed by women.

SELECT d.dept_name as Department_Name, CONCAT(e.first_name,'',e.last_name) AS Manager_Name
FROM departments AS d
JOIN dept_manager AS dm
ON dm.dept_no = d.dept_no
JOIN employees AS e
ON e.emp_no = dm.emp_no
JOIN dept_emp as de
ON de.emp_no = e.emp_no
WHERE e.gender = "F" AND dm.to_date = "9999-01-01"
ORDER BY Department_Name;

-- 4.Find the current titles of employees currently working in the Customer Service department.

SELECT t.title, COUNT(t.title)
FROM employees AS e
JOIN titles AS t
ON e.emp_no = t.emp_no
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
AND de.to_date = '9999-01-01'
AND t.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY title;

-- 5. Find the current salary of all current managers.

SELECT d.dept_name AS Department_Name, CONCAT(e.first_name,' ', e.last_name) AS Name, s.Salary
FROM employees AS e
JOIN dept_manager AS dm
ON e.emp_no = dm.emp_no
JOIN salaries AS s
ON e.emp_no = s.emp_no
JOIN departments as d
ON dm.dept_no = d.dept_no
WHERE dm.to_date = '9999-01-01'
AND s.to_date = '9999-01-01'
ORDER BY Department_Name;


-- 6. Find the number of current employees in each department.
SELECT d.dept_no, d.dept_name,COUNT(*) AS num_employees
FROM departments AS d 
JOIN dept_emp AS de
ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name, AVG (s.salary) AS average_salary
FROM departments as d
JOIN dept_emp as de
ON d.dept_no = de.dept_no
JOIN salaries AS s 
ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01'
AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY average_salary DESC;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT e.first_name,e.last_name, s.salary,d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no
JOIN salaries as s
ON e.emp_no = s.emp_no
WHERE d.dept_name = "Marketing"
AND de.to_date like '999%'
AND s.to_date like '999%'
ORDER BY s.salary DESC LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT d.dept_name AS Department_Name, CONCAT(e.first_name,' ', e.last_name) AS Name, s.salary
FROM employees AS e
JOIN dept_manager AS dm
ON e.emp_no = dm.emp_no
JOIN salaries AS s
ON e.emp_no = s.emp_no
JOIN departments as d
ON dm.dept_no = d.dept_no
WHERE dm.to_date = '9999-01-01' 
AND s.to_date = '9999-01-01' 
ORDER BY s.salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT d.dept_name, ROUND (AVG(s.salary)) AS Average_Salary
FROM departments AS d
JOIN dept_emp as de
ON d.dept_no = de.dept_no
JOIN salaries AS s
ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.








