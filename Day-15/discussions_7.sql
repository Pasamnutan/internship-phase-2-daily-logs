-- Query 1: Find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
-- This query uses a subquery to find the salary of 'Bull' and then compares other employees' salaries against it.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT SALARY FROM employees WHERE LAST_NAME = 'Bull');

-- Query 2: Find the name (first_name, last_name) of all employees who work in the IT department.
-- This query identifies the department ID for 'IT' and fetches the employees associated with that department.
SELECT FIRST_NAME, LAST_NAME
FROM employees
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_NAME = 'IT');

-- Query 3: Find the name (first_name, last_name) of the employees who have a manager and worked in a USA-based department.
-- This query identifies employees with managers and filters them based on the department's location in the USA.
SELECT FIRST_NAME, LAST_NAME
FROM employees
WHERE MANAGER_ID IS NOT NULL
AND DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID
    FROM departments
    WHERE LOCATION_ID IN (
        SELECT LOCATION_ID
        FROM locations
        WHERE COUNTRY_ID = 'US'
    )
);

-- Query 4: Find the name (first_name, last_name) of the employees who are managers.
-- This query finds employees who are listed as managers in the 'employees' table.
SELECT FIRST_NAME, LAST_NAME
FROM employees
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID FROM employees);

-- Query 5: Find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
-- This query compares each employee's salary against the average salary of all employees.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT AVG(SALARY) FROM employees);

-- Query 6: Find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their jobs.
-- This query finds employees whose salary matches the minimum salary defined for their job roles.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY = (SELECT MIN(SALARY) FROM jobs WHERE JOB_ID = employees.JOB_ID);

-- Query 7: Find the name (first_name, last_name), and salary of the employees who earn more than the average salary and work in any of the IT departments.
-- This query combines department and salary conditions to filter the desired employees.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT AVG(SALARY) FROM employees)
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_NAME LIKE 'IT%');

-- Query 8: Find the name (first_name, last_name), and salary of the employees who earn more than the earnings of Mr. Bell.
-- This query compares each employee's salary against the salary of 'Mr. Bell'.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT SALARY FROM employees WHERE LAST_NAME = 'Bell');

-- Query 9: Find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
-- This query finds employees earning the lowest salary across all departments.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY = (SELECT MIN(SALARY) FROM employees);

-- Query 10: Find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
-- This query ensures that employees' salaries are above the average calculated for all departments.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT AVG(SALARY) FROM employees);

-- Query 11: Find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerks (JOB_ID = 'SH_CLERK'). Sort the results of the salary from the lowest to highest.
-- This query compares employees' salaries against the highest salary of shipping clerks and sorts the result.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT MAX(SALARY) FROM employees WHERE JOB_ID = 'SH_CLERK')
ORDER BY SALARY ASC;

-- Query 12: Find the name (first_name, last_name) of the employees who are not managers.
-- This query lists employees who are not found in the manager's column of any department.
SELECT FIRST_NAME, LAST_NAME
FROM employees
WHERE EMPLOYEE_ID NOT IN (SELECT DISTINCT MANAGER_ID FROM employees WHERE MANAGER_ID IS NOT NULL);

-- Query 13: Display the employee ID, first name, last name, and department names of all employees.
-- This query joins employees with their respective departments to display comprehensive details.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, 
       (SELECT DEPARTMENT_NAME FROM departments WHERE departments.DEPARTMENT_ID = employees.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM employees;

-- Query 14: Display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
-- This query ensures employees' salaries are compared with their departmental averages.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employees e1
WHERE SALARY > (SELECT AVG(SALARY) FROM employees e2 WHERE e1.DEPARTMENT_ID = e2.DEPARTMENT_ID);

-- Query 15: Fetch even-numbered records from employees table.
-- This query selects employees based on even-numbered IDs.
SELECT *
FROM employees
WHERE MOD(EMPLOYEE_ID, 2) = 0;

-- Query 16: Find the 5th maximum salary in the employees table.
-- This query identifies the 5th highest salary using offset.
SELECT DISTINCT SALARY
FROM employees
ORDER BY SALARY DESC
LIMIT 1 OFFSET 4;

-- Query 17: Find the 4th minimum salary in the employees table.
-- This query identifies the 4th lowest salary using offset.
SELECT DISTINCT SALARY
FROM employees
ORDER BY SALARY
LIMIT 1 OFFSET 3;

-- Query 18: Select the last 10 records from a table.
-- This query selects the most recent 10 records based on employee ID.
SELECT *
FROM employees
ORDER BY EMPLOYEE_ID DESC
LIMIT 10;

-- Query 19: List the department ID and name of all the departments where no employee is working.
-- This query finds departments without any employees.
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM departments
WHERE DEPARTMENT_ID NOT IN (SELECT DISTINCT DEPARTMENT_ID FROM employees);

-- Query 20: Get 3 maximum salaries.
-- This query retrieves the top 3 highest distinct salaries.
SELECT DISTINCT SALARY
FROM employees
ORDER BY SALARY DESC
LIMIT 3;

-- Query 21: Get 3 minimum salaries.
-- This query retrieves the 3 lowest distinct salaries.
SELECT DISTINCT SALARY
FROM employees
ORDER BY SALARY
LIMIT 3;

-- Query 22: Get nth max salaries of employees.
-- Replace 'n' with the desired rank (e.g., 5 for the 5th maximum salary).
SELECT DISTINCT SALARY
FROM employees e1
WHERE (SELECT COUNT(DISTINCT e2.SALARY) FROM employees e2 WHERE e2.SALARY > e1.SALARY) = n - 1;
