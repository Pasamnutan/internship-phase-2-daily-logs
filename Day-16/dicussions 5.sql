-- Task 1: Find customers whose payments are greater than the average payment using a subquery
SELECT customerNumber, checkNumber, amount
FROM payments p
WHERE p.amount > (SELECT AVG(amount) FROM payments);

-- Task 2: Use a subquery with NOT IN operator to find the customers who have not placed any orders
SELECT c.customerName
FROM customers c
WHERE c.customerNumber NOT IN (SELECT o.customerNumber FROM orders o);

-- Task 3: Find the maximum, minimum, and average number of items in sale orders from orderdetails
SELECT MAX(items_count) AS maxItems, MIN(items_count) AS minItems, FLOOR(AVG(items_count)) AS avgItems
FROM (
    SELECT COUNT(*) AS items_count
    FROM orderdetails
    GROUP BY orderNumber
) AS subquery;

-- Task 4: Use a correlated subquery to select products whose buy prices are greater than the average buy price of all products in each product line
SELECT productName, buyPrice
FROM products p
WHERE p.buyPrice > (
    SELECT AVG(p2.buyPrice)
    FROM products p2
    WHERE p2.productLine = p.productLine
);

-- Task 5: Find sales orders whose total values are greater than 60K
SELECT o.orderNumber, SUM(od.priceEach * od.quantityOrdered) AS total_value
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
HAVING total_value > 60000;

-- Task 6: Find customers who placed at least one sales order with the total value greater than 60K using the EXISTS operator
SELECT c.customerNumber, c.customerName
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.customerNumber = c.customerNumber
    GROUP BY o.orderNumber
    HAVING SUM(od.priceEach * od.quantityOrdered) > 60000
);

-- Task 7: Get the top five products by sales revenue in 2003
SELECT od.productCode, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM orderdetails od
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE YEAR(o.shippedDate) = 2003
GROUP BY od.productCode
ORDER BY total_sales DESC
LIMIT 5;

-- Task 8: Find the productName and sales of the top 5 products in 2003
SELECT p.productName, top5.sales
FROM products p
JOIN (
    SELECT od.productCode, FLOOR(SUM(od.quantityOrdered * od.priceEach)) AS sales
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    WHERE YEAR(o.shippedDate) = 2003
    GROUP BY od.productCode
    ORDER BY sales DESC
    LIMIT 5
) AS top5 ON p.productCode = top5.productCode;

-- Task 9: Label customers who bought products in 2003 into groups
SELECT o.customerNumber, FLOOR(SUM(od.quantityOrdered * od.priceEach)) AS total_sales,
       CASE 
           WHEN SUM(od.quantityOrdered * od.priceEach) > 100000 THEN 'Platinum'
           WHEN SUM(od.quantityOrdered * od.priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
           ELSE 'Silver'
       END AS customer_group
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE YEAR(o.shippedDate) = 2003
GROUP BY o.customerNumber;

-- Task 10: Count the number of customers in each group
SELECT customer_group, COUNT(*) AS customer_count
FROM (
    SELECT o.customerNumber, 
           CASE 
               WHEN SUM(od.quantityOrdered * od.priceEach) > 100000 THEN 'Platinum'
               WHEN SUM(od.quantityOrdered * od.priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
               ELSE 'Silver'
           END AS customer_group
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE YEAR(o.shippedDate) = 2003
    GROUP BY o.customerNumber
) AS grouped_customers
GROUP BY customer_group;
