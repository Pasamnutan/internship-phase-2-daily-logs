-- Part 1: Basic Grouping and Aggregation in classicmodels

-- Task 1.1: Total Sales by Product Line
SELECT 
    p.productLine,
    SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM 
    orderdetails od
JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    p.productLine;

-- Task 1.2: Total Quantity Sold by Product Line
SELECT 
    p.productLine,
    SUM(od.quantityOrdered) AS totalQuantitySold
FROM 
    orderdetails od
JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    p.productLine;

-- Part 2: Advanced Grouping and Filtering with HAVING in classicmodels

-- Task 2.1: Average Sale Amount by Product Line with Filtering
SELECT 
    p.productLine,
    AVG(od.quantityOrdered * od.priceEach) AS avgSaleAmount
FROM 
    orderdetails od
JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    p.productLine
HAVING 
    avgSaleAmount > 500;

-- Part 3: Complex Aggregations in world

-- Task 3.1: Average Population and Total GDP by Continent
SELECT 
    co.Continent,
    AVG(co.Population) AS avgPopulation,
    SUM(co.GNP) AS totalGDP
FROM 
    country co
GROUP BY 
    co.Continent;

-- Task 3.2: Countries with Multiple Official Languages
SELECT 
    c.Name AS countryName,
    COUNT(cl.Language) AS numOfficialLanguages,
    c.Population
FROM 
    countrylanguage cl
JOIN 
    country c ON cl.CountryCode = c.Code
WHERE 
    cl.IsOfficial = 'T'
GROUP BY 
    cl.CountryCode
HAVING 
    numOfficialLanguages > 2;

-- Part 4: Time Series Analysis in classicmodels

-- Task 4.1: Month-over-Month Sales Growth
SELECT 
    YEAR(o.orderDate) AS orderYear,
    MONTH(o.orderDate) AS orderMonth,
    p.productLine,
    (SUM(od.quantityOrdered * od.priceEach) - LAG(SUM(od.quantityOrdered * od.priceEach), 1) OVER (PARTITION BY p.productLine ORDER BY YEAR(o.orderDate), MONTH(o.orderDate))) / LAG(SUM(od.quantityOrdered * od.priceEach), 1) OVER (PARTITION BY p.productLine ORDER BY YEAR(o.orderDate), MONTH(o.orderDate)) * 100 AS salesGrowthPercentage
FROM 
    orders o
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    orderYear, orderMonth, p.productLine;

-- Task 4.2: Quarterly Sales Analysis
SELECT 
    YEAR(o.orderDate) AS orderYear,
    QUARTER(o.orderDate) AS orderQuarter,
    o.officeCode,
    SUM(od.quantityOrdered * od.priceEach) AS totalQuarterlySales
FROM 
    orders o
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 
    orderYear, orderQuarter, o.officeCode;
