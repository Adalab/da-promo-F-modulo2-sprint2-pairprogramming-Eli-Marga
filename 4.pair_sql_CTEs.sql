USE Northwind;
SELECT customer_id,Company_name
FROM customers;
/*1.Extraer en una CTE todos los nombres de las compañias y los id de los clientes*/
/*Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.*/
WITH cte1 AS 
(SELECT customer_id,Company_name
FROM customers)
SELECT *
FROM cte1;
/*2.Selecciona solo los de que vengan de "Germany"*/
/*Ampliemos un poco la query anterior */
/*En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany"*/
WITH cte1 AS 
(SELECT customer_id,Company_name,country
FROM customers
WHERE country='Germany')
SELECT customer_id,Company_name
FROM cte1;
/*3.Extraed el id de las facturas y su fecha de cada cliente.*/
/*En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.*/
WITH cte1 AS 
(SELECT customer_id,Company_name AS company_name
FROM customers
GROUP BY customer_id)
SELECT orders.customer_id,cte.company_name,orders.order_id, orders.order_date
FROM orders
JOIN cte1 AS cte
ON orders.customer_id= cte.customer_id;
/*4.Contad el número de facturas por cliente */
/*Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/
SELECT customer_id,company_name,count(customer_id) AS num_facturas
FROM(
WITH cte1 AS 
(SELECT customer_id,Company_name AS company_name
FROM customers
GROUP BY customer_id)
SELECT orders.customer_id,cte.company_name,orders.order_id, orders.order_date
FROM orders
JOIN cte1 AS cte
ON orders.customer_id= cte.customer_id) AS facturas
GROUP BY customer_id;
/*5.Cuál la cantidad media pedida de todos los productos ProductID*/
/*Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media*/

SELECT product_name AS producto , media
FROM(
WITH cte2 AS
(SELECT AVG(order_details.quantity)AS media ,order_details.product_id
FROM order_details
GROUP BY order_details.product_id)
SELECT products.product_id,products.product_name,cte2.media
FROM products
JOIN cte2 AS cte2
ON cte2.product_id= products.product_id) AS average
GROUP BY product_id;




