-- Database & Cleaning Section

CREATE DATABASE retail_sales;

USE retail_sales;

SELECT *
FROM retail_sales_dataset;


ALTER TABLE retail_sales_dataset
RENAME COLUMN ï»¿order_id TO order_id;

-- Check Missing Values

SELECT *
FROM retail_sales_dataset
WHERE customer_name IS NULL
   OR order_id IS NULL;

-- Duplicate Detection

SELECT order_id, COUNT(*)
FROM retail_sales_dataset
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Category Performance

SELECT category,
SUM(sales) AS total_sales
FROM retail_sales_dataset
GROUP BY category
ORDER BY total_sales DESC;


-- Poor Performing Category

SELECT category,
SUM(sales) AS poor_value
FROM retail_sales_dataset
GROUP BY category
ORDER BY poor_value ASC;

-- Top Selling Products

SELECT product,
SUM(sales) AS total_sales
FROM retail_sales_dataset
GROUP BY product
ORDER BY total_sales DESC
LIMIT 5;

-- Highest Profit City
SELECT city,
ROUND(SUM(profit),2) AS total_profit
FROM retail_sales_dataset
GROUP BY city
ORDER BY total_profit DESC;

-- MONTHWISE Analysis

SELECT MONTH(order_date) AS month,
SUM(sales) AS sales
FROM retail_sales_dataset
GROUP BY MONTH(order_date)
ORDER BY month;

-- Yearly Profit

SELECT YEAR(order_date) AS year,
SUM(profit) AS profit
FROM retail_sales_dataset
GROUP BY year;

-- Top Customers

SELECT customer_name,
SUM(sales) AS total_sales
FROM retail_sales_dataset
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Customer Segmentation using CASE

SELECT customer_name,
SUM(sales) AS total_sales,

CASE
    WHEN SUM(sales) > 50000 THEN 'Premium Customer'
    ELSE 'Regular Customer'
END AS customer_category

FROM retail_sales_dataset
GROUP BY customer_name;


-- Profit Margin Analysis 
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,

ROUND(
    (SUM(profit) / SUM(sales)) * 100,
    2
) AS profit_margin

FROM retail_sales_dataset
GROUP BY category
ORDER BY profit_margin DESC;

-- Analyze Category-wise Profit using Common Table Expression (CTE)

WITH category_profit AS (

    SELECT
        category,
        SUM(profit) AS total_profit
    FROM retail_sales_dataset
    GROUP BY category
)

SELECT *
FROM category_profit
WHERE total_profit > 5600000;

-- Find Products with Above Average Sales

SELECT product,
SUM(sales) AS total_sales
FROM retail_sales_dataset
GROUP BY product

HAVING SUM(sales) >
(
    SELECT AVG(sales)
    FROM retail_sales_dataset
);

-- Rank Categories by Total Sales

SELECT
    category,
    SUM(sales) AS total_sales,

RANK() OVER(
    ORDER BY SUM(sales) DESC
) AS sales_rank

FROM retail_sales_dataset
GROUP BY category;



