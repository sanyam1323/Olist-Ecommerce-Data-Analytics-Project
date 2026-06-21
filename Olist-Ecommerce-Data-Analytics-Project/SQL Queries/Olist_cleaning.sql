/*
==========================================
OLIST E-COMMERCE DATA CLEANING
==========================================
*/

-- Check Missing Values

SELECT
COUNT(*) AS total_rows,
SUM(order_id IS NULL) AS missing_order_id,
SUM(customer_id IS NULL) AS missing_customer_id,
SUM(order_status IS NULL) AS missing_status
FROM orders;

-- Check Duplicate Orders

SELECT
order_id,
COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check Table Structure

DESCRIBE orders;

-- Convert Date Columns (if imported as text)

ALTER TABLE orders
MODIFY order_purchase_timestamp DATETIME;

ALTER TABLE orders
MODIFY order_approved_at DATETIME;

ALTER TABLE orders
MODIFY order_delivered_carrier_date DATETIME;

ALTER TABLE orders
MODIFY order_delivered_customer_date DATETIME;

ALTER TABLE orders
MODIFY order_estimated_delivery_date DATETIME;