USE sales_analysis;

-- Analyze the complete dataset after running 02_data_cleaning.sql.
-- Sales already contains each order line's sales amount.
-- Do not multiply Sales by Quantity.

-- 1. Overall sales performance
SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    SUM(Quantity) AS total_units_sold,
    ROUND(
        SUM(Sales) /
        NULLIF(COUNT(DISTINCT `Order ID`), 0),
        2
    ) AS average_order_value
FROM sales_clean;

-- 2. Sales and profit by category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold
FROM sales_clean
GROUP BY Category
ORDER BY total_sales DESC, Category;

-- 3. Top five products by sales
SELECT
    `Product ID`,
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_clean
GROUP BY `Product ID`, `Product Name`
ORDER BY total_sales DESC, `Product ID`, `Product Name`
LIMIT 5;

-- 4. Top five customers by spending
SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_spending,
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM sales_clean
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_spending DESC, `Customer ID`, `Customer Name`
LIMIT 5;

-- 5. Top ten cities by sales
-- State distinguishes cities with the same name.
SELECT
    State,
    City,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_clean
GROUP BY State, City
ORDER BY total_sales DESC, State, City
LIMIT 10;

-- 6. Monthly sales trends
-- Group by year and month so different years stay separate.
SELECT
    DATE_FORMAT(
        STR_TO_DATE(TRIM(`Order Date`), '%m/%d/%Y'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM sales_clean
GROUP BY sales_month
ORDER BY sales_month;