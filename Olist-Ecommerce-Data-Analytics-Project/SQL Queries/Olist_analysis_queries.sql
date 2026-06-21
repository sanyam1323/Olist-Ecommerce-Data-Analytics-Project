/*
==========================================
OLIST E-COMMERCE DATA ANALYSIS
==========================================
*/

-- 1. Total Number of Orders

SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Total Number of Customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- 3. Total Number of Products

SELECT COUNT(*) AS total_products
FROM products;

-- 4. Total Number of Sellers

SELECT COUNT(*) AS total_sellers
FROM sellers;

-- 5. Count Orders by Order Status

SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 6. Top 10 Customer Cities by Number of Orders

SELECT
c.customer_city,
COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- 7. Top 10 Customer States by Number of Orders

SELECT
c.customer_state,
COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;

-- 8. Total Payments by Payment Type

SELECT
payment_type,
COUNT(*) AS total_payments
FROM payments
GROUP BY payment_type
ORDER BY total_payments DESC;

-- 9. Average Order Payment Value

SELECT
ROUND(AVG(payment_value),2) AS average_payment
FROM payments;

-- 10. Top 10 Product Categories by Order Count

SELECT
p.product_category_name,
COUNT(oi.order_id) AS total_orders
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_orders DESC
LIMIT 10;

-- 11. Total Sales by Customer State

SELECT
c.customer_state,
ROUND(SUM(p.payment_value),2) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_sales DESC;

-- 12. Total Sales by Customer City

SELECT
c.customer_city,
ROUND(SUM(p.payment_value),2) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY total_sales DESC;

-- 13. Top 10 Product Categories by Total Sales

SELECT
p.product_category_name,
ROUND(SUM(oi.price),2) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;

-- 14. Top 10 Sellers by Revenue

SELECT
seller_id,
ROUND(SUM(price),2) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- 15. Monthly Order Count

SELECT
YEAR(order_purchase_timestamp) AS year,
MONTH(order_purchase_timestamp) AS month,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
ORDER BY year, month;

-- 16. Customers Who Placed More Than One Order

SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- 17. Average Freight Value by Product Category

SELECT
p.product_category_name,
ROUND(AVG(oi.freight_value),2) AS avg_freight_value
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY avg_freight_value DESC;

-- 18. Sellers with Revenue Above Average Seller Revenue

SELECT
seller_id,
SUM(price) AS total_revenue
FROM order_items
GROUP BY seller_id
HAVING SUM(price) >
(
SELECT AVG(seller_revenue)
FROM
(
SELECT
seller_id,
SUM(price) AS seller_revenue
FROM order_items
GROUP BY seller_id
) AS seller_avg
);

-- 19. Average Delivery Time in Days

SELECT
ROUND(
AVG(
DATEDIFF(
order_delivered_customer_date,
order_purchase_timestamp
)
),2
) AS avg_delivery_days
FROM orders
WHERE order_status = 'delivered';

-- 20. Total Late Deliveries

SELECT
COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date >
order_estimated_delivery_date
AND order_status = 'delivered';

