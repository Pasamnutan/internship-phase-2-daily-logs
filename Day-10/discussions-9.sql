-- List the number of jobs available in the employees table
SELECT COUNT(DISTINCT job_id) AS num_jobs_available
FROM employees;

-- Get the total salaries payable to employees
SELECT SUM(salary) AS total_salaries_payable
FROM employees;

-- Get the minimum salary from the employees table
SELECT MIN(salary) AS min_salary
FROM employees;

-- Get the maximum salary of an employee working as a Programmer
SELECT MAX(salary) AS max_programmer_salary
FROM employees
WHERE job_id = 'Programmer';

-- Get the average salary and number of employees working in department 90
SELECT AVG(salary) AS avg_salary, COUNT(*) AS num_employees
FROM employees
WHERE department_id = 90;

-- Get the highest, lowest, sum, and average salary of all employees
SELECT MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       SUM(salary) AS total_salary,
       AVG(salary) AS avg_salary
FROM employees;

-- Get the number of employees with the same job
SELECT job_id, COUNT(*) AS num_employees_with_job
FROM employees
GROUP BY job_id;

-- Get the difference between the highest and lowest salaries
SELECT MAX(salary) - MIN(salary) AS salary_difference
FROM employees;

-- Find the manager ID and the salary of the lowest-paid employee for that manager
SELECT manager_id, MIN(salary) AS lowest_salary
FROM employees
GROUP BY manager_id;

-- Get the department ID and the total salary payable in each department
SELECT department_id, SUM(salary) AS total_salary_payable
FROM employees
GROUP BY department_id;
