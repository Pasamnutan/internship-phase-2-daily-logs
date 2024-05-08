-- Task 1.1: Wildcard Searches for Product Names
SELECT productName FROM products WHERE productName LIKE 'Classic%Car';

-- Explanation: Finds product names starting with "Classic" and ending with "Car".

-- Task 1.2: Flexible Search for Customer Addresses
SELECT addressLine1 FROM customers WHERE addressLine1 LIKE '%Street%' OR addressLine1 LIKE '%Avenue%';

-- Explanation: Matches addresses containing "Street" or "Avenue" anywhere in the string.

-- Task 2.1: Orders within a Price Range
SELECT o.orderNumber, SUM(od.priceEach * od.quantityOrdered) AS totalAmount
FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber HAVING totalAmount BETWEEN 1000 AND 2000;

-- Explanation: Summarizes order amounts and filters those within a specified range.

-- Task 2.2: Payments within a Date Range
SELECT * FROM payments WHERE paymentDate BETWEEN '2004-01-01' AND '2004-06-30';

-- Explanation: Selects payments made within a specific date range.

-- Task 3.1: Orders Exceeding Average Sale Amount
SELECT orderNumber, SUM(priceEach * quantityOrdered) AS totalAmount
FROM orderdetails GROUP BY orderNumber
HAVING totalAmount > ANY (SELECT AVG(totalAmount) FROM (SELECT SUM(priceEach * quantityOrdered) AS totalAmount FROM orderdetails GROUP BY orderNumber) AS avg_sales);

-- Explanation: Identifies orders with total amounts exceeding the average sale amount.

-- Task 3.2: Products with Maximum Order Quantity
SELECT productName FROM products WHERE quantityOrdered = ALL (SELECT MAX(quantityOrdered) FROM orderdetails);

-- Explanation: Selects products with the maximum order quantity.

-- Task 4.1: High-Value Customers in Specific Regions
SELECT c.customerName, c.country, p.amount
FROM customers c JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.amount > ANY (SELECT 0.9 * MAX(amount) FROM payments)
AND (c.country LIKE 'USA' OR c.country LIKE 'Canada');

-- Explanation: Identifies high-value customers in specific regions.

-- Task 4.2: Seasonal Sales Analysis
SELECT productName, MONTH(orderDate) AS month, SUM(priceEach * quantityOrdered) AS monthlySales,
       AVG(priceEach * quantityOrdered) AS avgAnnualSales
FROM products pr JOIN orderdetails od ON pr.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY productName, MONTH(orderDate)
HAVING monthlySales > ALL (SELECT 1.2 * AVG(priceEach * quantityOrdered) FROM orderdetails GROUP BY MONTH(orderDate))
AND (MONTH(orderDate) BETWEEN 6 AND 8);

-- Explanation: Analyzes seasonal sales against annual averages.
