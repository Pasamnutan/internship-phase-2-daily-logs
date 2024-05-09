-- 1. Find the addresses of all the departments
SELECT d.location_id, l.street_address, l.city, l.state_province, c.country_name 
FROM departments d
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id;

-- 2. Find the name, department ID, and department name of all the employees
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name, e.department_id, d.department_name 
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 3. Find the name, job, and department details of the employees who work in London
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name, j.job_title, e.department_id, d.department_name 
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'London';

-- 4. Find the employee ID, last name, manager ID, and manager's last name
SELECT e1.employee_id, e1.last_name, e1.manager_id, e2.last_name 
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 5. Find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'
SELECT CONCAT(first_name, ' ', last_name) AS name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Jones');

-- 6. Get the department name and number of employees in the department
SELECT d.department_name, COUNT(*) AS num_employees 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 7. Get the employee ID, job title, and number of days between the ending date and the starting date for all jobs in department 90
SELECT e.employee_id, j.job_title, DATEDIFF(jh.end_date, jh.start_date) AS days_difference 
FROM employees e
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN jobs j ON jh.job_id = j.job_id
WHERE e.department_id = 90;

-- 8. Display the department ID and name and the first name of the manager
SELECT d.department_id, d.department_name, CONCAT(e.first_name, ' ', e.last_name) AS manager_name 
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id;

-- 9. Display the department name, manager name, and city
SELECT d.department_name, CONCAT(e.first_name, ' ', e.last_name) AS manager_name, l.city 
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
JOIN locations l ON d.location_id = l.location_id;

-- 10. Display the job title and average salary of employees
SELECT j.job_title, AVG(e.salary) AS avg_salary 
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;

-- 11. Display job title, employee name, and the difference between the employee's salary and the minimum salary for the job
SELECT j.job_title, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, e.salary - j.min_salary AS salary_difference 
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;

-- 12. Display the job history of any employee who is currently drawing more than 10000 in salary
SELECT jh.* 
FROM job_history jh
JOIN employees e ON jh.employee_id = e.employee_id
WHERE e.salary > 10000;

-- 13. Display department name, name (first_name, last_name), hire date, and salary of the manager for all managers whose experience is more than 15 years
SELECT d.department_name, CONCAT(e.first_name, ' ', e.last_name) AS manager_name, e.hire_date, e.salary 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id = d.manager_id 
AND DATEDIFF(CURRENT_DATE(), e.hire_date) > 15*365;
