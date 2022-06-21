SELECT	* FROM employees
SELECT	* FROM titles
SELECT * FROM retirement_titles LIMIT (10)
SELECT * FROM unique_titles LIMIT (10)

-------------------------------------------------------DELIVEREABLE #1 -----------------------------------------------------------------
-- 1. Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.
-- 3. Create a new table using the INTO clause.
-- 4. Join both tables on the primary key.
-- 5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT emp.emp_no, 
	emp.first_name, 
	emp.last_name,
	tit.title,
	tit.from_date, 
	tit.to_date
INTO retirement_titles
FROM employees as emp
INNER JOIN titles as tit
ON (emp.emp_no = tit.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no
;


-- 9. Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
-- 10. Use Dictinct with Orderby to remove duplicate rows
-- 11. Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
-- 12. Create a Unique Titles table using the INTO clause.
-- 13. Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, 
	emp.first_name, 
	emp.last_name,
	tit.title
INTO unique_titles
FROM employees as emp
INNER JOIN titles as tit
ON (emp.emp_no = tit.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	and (tit.to_date = '9999-01-01')
ORDER BY emp_no ASC
;


-- Retrieve the number of employees by their most recent job title who are about to retire.
-- 17. First, retrieve the number of titles from the Unique Titles table.
-- 18. Then, create a Retiring Titles table to hold the required information.
-- 19. Group the table by title, then sort the count column in descending order.
SELECT title, COUNT(title)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "count" DESC
;

-------------------------------------------------------DELIVEREABLE #2 -----------------------------------------------------------------
-- Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
--Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key
--Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
--Order the table by the employee number.

SELECT DISTINCT ON (emp.emp_no) 
	emp.emp_no, 
	emp.first_name, 
	emp.last_name,
	emp.birth_date,
	demp.from_date,
	demp.to_date,
	tit.title
INTO mentorship_eligibilty
FROM employees as emp
INNER JOIN dept_employees as demp
ON (emp.emp_no = demp.emp_no)
INNER JOIN titles as tit
ON (emp.emp_no = tit.emp_no)
WHERE (demp.to_date = '9999-01-01') 
	AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC 
;



SELECT title, COUNT(title)
INTO mentorship_titles
FROM mentorship_eligibilty
GROUP BY title
ORDER BY "count" DESC
;
--------------------------------------------------------------------------------------------------------------------------------------
-- Retirement Titles Table
SELECT * FROM retirement_titles 
LIMIT 10

-- Unique Titles Table
SELECT * FROM unique_titles	
LIMIT 10

-- Retiring Titles Table
SELECT * FROM retiring_titles

SELECT COUNT(title) AS "Number of Retirees"
FROM unique_titles

-- Mentorship Eligibilty Table
SELECT * FROM mentorship_eligibilty
LIMIT 10

-- numb retirees vs num of mentees
SELECT  rt.title as job_title, rt.count as number_mentors, mt.count as number_mentees
INTO mentors_vs_mentees
FROM retiring_titles as rt
FULL JOIN mentorship_titles as mt
ON (rt.title = mt.title)
ORDER BY number_mentors DESC

SELECT * FROM mentors_vs_mentees
