#1. Top 5 Customers by Total Amount Spent:
SELECT
    c.customerNumber,
    c.customerName,
    SUM(od.priceEach * od.quantityOrdered) AS totalAmountSpent
FROM
    customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    c.customerNumber, c.customerName
ORDER BY
    totalAmountSpent DESC
LIMIT 5;

#2. Sales Performance Comparison between Sales Reps:
SELECT
    e.employeeNumber,
    e.firstName,
    e.lastName,
    SUM(od.priceEach * od.quantityOrdered) AS totalSales
FROM
    employees e
    JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    e.employeeNumber, e.firstName, e.lastName
ORDER BY
    totalSales DESC;


#3. Average Order Value by Country:
SELECT
    c.country,
    AVG(od.priceEach * od.quantityOrdered) AS avgOrderValue
FROM
    orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN customers c ON o.customerNumber = c.customerNumber
GROUP BY
    c.country
ORDER BY
    avgOrderValue DESC;



#4. Product-wise Sales and Profitability:
SELECT
    p.productCode,
    p.productName,
    SUM(od.quantityOrdered) AS totalQuantitySold,
    SUM(od.priceEach * od.quantityOrdered) AS totalRevenue,
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) AS totalProfit
FROM
    products p
    JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY
    p.productCode, p.productName
ORDER BY
    totalRevenue DESC;




#5. Monthly Sales Growth:
SELECT
    DATE_FORMAT(o.orderDate, '%Y-%m') AS month,
    SUM(od.priceEach * od.quantityOrdered) AS monthlySales
FROM
    orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    month
ORDER BY
    month;



#6. Orders Shipped Late:
SELECT
    o.orderNumber,
    o.orderDate,
    o.requiredDate,
    o.shippedDate
FROM
    orders o
WHERE
    o.shippedDate > o.requiredDate;




#7. Most Popular Product Line:
SELECT
    prl.productLine,
    SUM(od.quantityOrdered) AS totalQuantitySold
FROM
    orderdetails od
    JOIN products p ON od.productCode = p.productCode
    JOIN productlines prl ON p.productLine = prl.productLine
GROUP BY
    prl.productLine
ORDER BY
    totalQuantitySold DESC
LIMIT 1;



#8. Sales Rep Performance by Country:
SELECT
    e.employeeNumber,
    e.firstName,
    e.lastName,
    c.country,
    SUM(od.priceEach * od.quantityOrdered) AS totalSales
FROM
    employees e
    JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    e.employeeNumber, e.firstName, e.lastName, c.country
ORDER BY
    totalSales DESC;


#9. Product Return Analysis:
SELECT
    p.productCode,
    p.productName,
    COUNT(o.orderNumber) AS totalReturns
FROM
    orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    JOIN products p ON od.productCode = p.productCode
WHERE
    o.status = 'Cancelled'  -- Adjust based on your data model
GROUP BY
    p.productCode, p.productName
ORDER BY
    totalReturns DESC;

