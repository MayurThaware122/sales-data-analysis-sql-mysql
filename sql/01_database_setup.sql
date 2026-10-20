-- Create the project database
CREATE DATABASE IF NOT EXISTS sales_analysis;

-- Select the database
USE sales_analysis;
CREATE TABLE IF NOT EXISTS `sales_raw`  (
  `Row ID` int DEFAULT NULL,
  `Order ID` text,
  `Order Date` text,
  `Ship Date` text,
  `Ship Mode` text,
  `Customer ID` text,
  `Customer Name` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `Postal Code` int DEFAULT NULL,
  `Region` text,
  `Product ID` text,
  `Category` text,
  `Sub-Category` text,
  `Product Name` text,
  `Sales` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;