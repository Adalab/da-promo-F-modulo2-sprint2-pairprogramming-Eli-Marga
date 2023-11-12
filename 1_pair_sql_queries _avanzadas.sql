/*1*Productos más baratos y caros de nuestra BBDD:
Desde la división de productos nos piden conocer 
el precio de los productos que tienen el precio más alto*/
USE northwind;
SELECT MIN(unit_price) AS lowestPrice, MAX(unit_price) AS highestPrice
FROM products;
/*2*/
SELECT COUNT(product_id), AVG(unit_price)
FROM products;
/*3*/
SELECT MIN(freight) AS Min_carga, MAX(freight) AS Max_carga
FROM orders
WHERE ship_country = 'UK';
/*4*/
SELECT AVG(unit_price) AS Precio_medio
FROM products;
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) AS Precio_medio FROM products)
ORDER BY unit_price DESC;
/*5*/
SELECT discontinued
FROM products
WHERE discontinued = 1;
/*6*/
SELECT product_id, product_name
FROM products
WHERE discontinued = 0
ORDER BY product_id DESC
LIMIT 10;
/*7*/
SELECT employee_id, COUNT(order_id) AS Num_pedidos, MAX(freight) AS Max_carga
FROM orders
GROUP BY employee_id;
/*8*/
SELECT employee_id , COUNT(order_id) AS Num_pedidos, MAX(freight) AS Max_carga
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY employee_id;
/*9*/
SELECT DAY(order_date) AS Dia, MONTH(order_date) AS Mes, YEAR(order_date) AS Año, COUNT(order_id)
FROM orders
GROUP BY Dia, Mes, Año;
/*10*/
SELECT MONTH(order_date) AS Mes, YEAR(order_date) AS Año, COUNT(order_id)
FROM orders
GROUP BY Mes, Año;
/*11*/
SELECT city, COUNT(employee_id) AS Num_empleadas
FROM employees
GROUP BY city
HAVING Num_empleadas>=4;
/*12*/
SELECT order_id, quantity, unit_price,
	CASE 
		WHEN (unit_price*quantity)>2000 THEN "Alto"
		ELSE "Bajo"
	END AS Categoria
FROM order_details;


