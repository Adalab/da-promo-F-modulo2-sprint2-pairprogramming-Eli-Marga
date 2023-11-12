USE northwind;
SELECT *
FROM customers;
SELECT *
FROM orders;
/*1*/
SELECT customers.customer_id, customers.company_name, COUNT(orders.customer_id)
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY orders.customer_id;
/*2*/
SELECT  YEAR(orders.order_date) AS Año, 
customers.company_name
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id, orders.order_date;

SELECT YEAR(orders.order_date) AS Año, 
customers.company_name, order_details.quantity
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id= order_details.order_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id, orders.order_date, order_details.quantity ;


