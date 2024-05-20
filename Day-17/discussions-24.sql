-- Updatable View
CREATE VIEW UpdatableCustomerInfo AS
SELECT customerNumber, customerName, contactLastName, contactFirstName
FROM customers;

-- Try to update contactFirstName for a specific customerNumber
UPDATE UpdatableCustomerInfo
SET contactFirstName = 'NewFirstName'
WHERE customerNumber = specific_customer_number;

-- Read-Only View
CREATE VIEW OrderDetailsReadOnly AS
SELECT o.orderNumber, p.productName, od.quantityOrdered
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode;

-- Trying to update the quantityOrdered for a specific orderNumber will result in an error.
-- Attempting to update data in this view will fail because it's defined as read-only.

-- Inline View
SELECT customerNumber, COUNT(orderNumber) AS totalOrders
FROM (
    SELECT customerNumber, orderNumber
    FROM orders
) AS inline_view
GROUP BY customerNumber;

-- Materialized View (using Stored Procedure and Trigger)
DELIMITER //
CREATE PROCEDURE UpdateMaterializedView()
BEGIN
    CREATE TABLE IF NOT EXISTS MaterializedView (
        productName VARCHAR(100),
        totalQuantityOrdered INT
    );

    DELETE FROM MaterializedView;

    INSERT INTO MaterializedView (productName, totalQuantityOrdered)
    SELECT p.productName, SUM(od.quantityOrdered) AS totalQuantityOrdered
    FROM orderdetails od
    JOIN products p ON od.productCode = p.productCode
    GROUP BY p.productName;
END //
DELIMITER ;

CREATE TRIGGER AfterOrderDetailsInsert
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
    CALL UpdateMaterializedView();
END;
