USE sales_analysis;

-- 1. Verify the complete source import
-- Expected: 9,994 rows and 9,994 unique Row IDs.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Row ID`) AS unique_row_ids
FROM sales_raw_complete;

-- 2. Rebuild the clean table, removing identical duplicate rows
-- This replaces only sales_clean and preserves the source table.
DROP TABLE IF EXISTS sales_clean;

CREATE TABLE sales_clean AS
SELECT DISTINCT *
FROM sales_raw_complete;

-- 3. Verify the clean table and sales total
-- Expected: 9,994 rows, 9,994 unique IDs, sales of 2,297,200.86.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Row ID`) AS unique_row_ids,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_clean;

-- 4. Check essential fields for missing values
-- Expected: all results are 0.
SELECT
    SUM(`Row ID` IS NULL) AS missing_row_ids,
    SUM(
        `Order ID` IS NULL OR TRIM(`Order ID`) = ''
    ) AS missing_order_ids,
    SUM(
        `Order Date` IS NULL OR TRIM(`Order Date`) = ''
    ) AS missing_order_dates,
    SUM(Sales IS NULL) AS missing_sales,
    SUM(Quantity IS NULL) AS missing_quantities,
    SUM(Profit IS NULL) AS missing_profit
FROM sales_clean;

-- 5. Preview order-date conversion
-- Source format: month/day/year.
-- Dates remain stored as text; this query previews their conversion.
SELECT
    `Order Date` AS original_date,
    STR_TO_DATE(
        TRIM(`Order Date`), '%m/%d/%Y'
    ) AS converted_date
FROM sales_clean
ORDER BY `Row ID`
LIMIT 10;

-- 6. Check all order dates for failed conversions
-- Expected: 0.
SELECT
    COUNT(*) AS failed_date_conversions
FROM sales_clean
WHERE STR_TO_DATE(
    TRIM(`Order Date`), '%m/%d/%Y'
) IS NULL;