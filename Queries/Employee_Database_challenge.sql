-- Deliverable 1: Retirement Titles table
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' and '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO retirement_unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- To retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT (emp_no), title
INTO retiring_titles
FROM retirement_unique_titles
GROUP BY title
ORDER BY count DESC;

-- Deliverable 2 : Mentorship Eiligibility table
-- To create a Mentorship Eligibility Table (employees who are eligible to participate in a mentorship program)
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
	ON e.emp_no = de.emp_no
RIGHT JOIN titles as t
	ON (e.emp_no = t.emp_no)AND (de.to_date=t.to_date)
WHERE (e.birth_date BETWEEN '1965-01-01' and '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC;