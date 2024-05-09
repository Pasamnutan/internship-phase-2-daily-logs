-- 1. Display a list of customers who locate in the same city by joining the customers table to itself
SELECT c1.customerName, c1.city
FROM customers c1
JOIN customers c2 ON c1.customerNumber <> c2.customerNumber
AND c1.city = c2.city;

-- 2. Get the productCode, productName, and textDescription of product lines
SELECT p.productCode, p.productName, pl.textDescription
FROM products p
JOIN productlines pl ON p.productLine = pl.productLine;

-- 3. Query to get order number, order status, and total sales from the orders and orderdetails tables
SELECT o.orderNumber, o.status, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber, o.status;

-- 4. Fetch complete details of orders from orders, orderDetails, and products table and sort by orderNumber and orderLineNumber
SELECT o.*, od.*, p.*
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
ORDER BY o.orderNumber, od.orderLineNumber;

-- 5. Perform INNER JOIN of four tables and display details sorted by orderNumber and orderLineNumber
SELECT o.*, od.*, p.*, c.*
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY o.orderNumber, od.orderLineNumber;

-- 6. Find the sales price of the product whose code is S10_1678 that is less than MSRP
SELECT *
FROM products
WHERE productCode = 'S10_1678' AND buyPrice < MSRP;

-- 7. Find all customers and their orders
SELECT c.customerNumber, c.customerName, o.orderNumber, o.orderDate
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber;

-- 8. Use LEFT JOIN to find customers who have no orders
SELECT c.customerNumber, c.customerName
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL;
