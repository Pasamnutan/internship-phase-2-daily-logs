-- Scenario 1: Advanced Analytics Dashboard
-- Inline view to calculate daily total sales
CREATE VIEW DailyTotalSales AS
SELECT orderDate, SUM(quantityOrdered * priceEach) AS totalSales
FROM orders
GROUP BY orderDate;

-- Updatable view to show number of orders for each day and update order status
CREATE VIEW OrderStatus AS
SELECT orderDate, COUNT(orderNumber) AS totalOrders, status
FROM orders
GROUP BY orderDate, status
WITH CHECK OPTION;

-- View to identify the most purchased product of each day
CREATE VIEW MostPurchasedProduct AS
SELECT orderDate, productName, MAX(quantityOrdered) AS maxQuantity
FROM orders
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
GROUP BY orderDate;

-- Combine views to produce daily report
SELECT o.orderDate, o.totalOrders, s.totalSales, p.productName AS mostPurchasedProduct
FROM OrderStatus o
JOIN DailyTotalSales s ON o.orderDate = s.orderDate
JOIN MostPurchasedProduct p ON o.orderDate = p.orderDate;

-- Scenario 2: Sales Monitoring System
-- View to show total number of customers handled by each sales rep
CREATE VIEW CustomersHandled AS
SELECT salesRepEmployeeNumber, COUNT(DISTINCT customerNumber) AS totalCustomers
FROM orders
GROUP BY salesRepEmployeeNumber;

-- View to display total payments received by each sales rep
CREATE VIEW PaymentsReceived AS
SELECT salesRepEmployeeNumber, SUM(amount) AS totalPayments
FROM payments
GROUP BY salesRepEmployeeNumber;

-- View to show total number of orders handled by each sales rep
CREATE VIEW OrdersHandled AS
SELECT salesRepEmployeeNumber, COUNT(orderNumber) AS totalOrders
FROM orders
GROUP BY salesRepEmployeeNumber;

-- Combined view to display performance of each sales rep
SELECT e.employeeNumber, e.lastName, e.firstName, c.totalCustomers, p.totalPayments, o.totalOrders
FROM employees e
LEFT JOIN CustomersHandled c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN PaymentsReceived p ON e.employeeNumber = p.salesRepEmployeeNumber
LEFT JOIN OrdersHandled o ON e.employeeNumber = o.salesRepEmployeeNumber;

-- Scenario 3: HR and Sales Data Analysis
-- View in the HR database showing department and age of each employee
CREATE VIEW EmployeeDetails AS
SELECT employeeNumber, department, age
FROM hr_database.employee;

-- View in the classicmodels database showing sales performance of each employee
CREATE VIEW SalesPerformance AS
SELECT salesRepEmployeeNumber, COUNT(DISTINCT customerNumber) AS totalCustomers, SUM(amount) AS totalPayments, COUNT(orderNumber) AS totalOrders
FROM orders
JOIN payments USING (customerNumber)
GROUP BY salesRepEmployeeNumber;
