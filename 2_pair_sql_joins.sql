USE northwind; 




-- EJERCICIO 1 

USE northwind; 

SELECT customers.customer_id, customers.company_name, COUNT(orders.customer_id)
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY orders.customer_id; 

-- EJERCICIO 2 
-- 1 para sacar el nombre de empresa y año: 
SELECT customers.company_name, YEAR(orders.order_date) AS Anio
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, YEAR(orders.order_date);

-- 2 para sacar la cantidad de objetos pedidos: 
SELECT customers.company_name, YEAR(orders.order_date) AS Anio , SUM(order_details.quantity) AS NumObjetos
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id
WHERE customers.country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date); 

-- EJERCICIO 3 

-- 1 para sacar el nombre de empresa y año: 
SELECT customers.company_name, YEAR(orders.order_date) AS Anio
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, YEAR(orders.order_date);

-- 2 para sacar la cantidad de objetos pedidos: 
SELECT 
	customers.company_name, 
	YEAR(orders.order_date) AS Anio , 
	SUM(order_details.quantity) AS NumObjetos
	
FROM customers
    
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id

WHERE customers.country = "UK"

GROUP BY customers.company_name, YEAR(orders.order_date); 

-- 3 para sacar el total de dinero gastado por compañía-año: 

SELECT 
	customers.company_name, 
	YEAR(orders.order_date) AS Anio, 
	SUM(order_details.quantity) AS NumObjetos, 
	SUM(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) AS Cantidad_de_Dinero
    
FROM customers 

JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id

WHERE customers.country = "UK"

GROUP BY customers.company_name, YEAR(orders.order_date); 

-- 4 Sacar el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.

SELECT 
	customers.company_name, 
    orders.order_date AS Fecha,
    orders.order_id
    
    FROM customers 
    
    JOIN orders ON customers.customer_id = orders.customer_id
    
    GROUP BY orders.order_id, customers.company_name, Fecha; 


-- 5 Tipo de productos vendidos. 
USE northwind; 

SELECT 
	categories.category_name, 
    products.product_name, 
    products.product_id,
	SUM(order_details.quantity * order_details.unit_price * (1 - order_details.discount)) AS Total_de_Dinero

FROM products  

JOIN categories ON categories.category_id = products.category_id
JOIN order_details ON order_details.product_id = products.product_id

GROUP BY products.category_id, products.product_name, products.product_id;




-- 6. Empresas que tenemos en northwind: sacar el nombre de todas las empresas cliente, los Ids de sus pedidos y las fechas. 

SELECT 
	orders.order_id, customers.company_name, orders.order_date

FROM orders

JOIN customers ON customers.customer_id = orders.customer_id; 


-- 7. Pedidos por cliente en UK: sacar el nombre de cada empresa cliente y el num de pedidos 

SELECT
	customers.company_name, 
    COUNT(orders.customer_id) AS NumeroPedidos 
    
    FROM customers
    JOIN orders ON customers.customer_id = orders.customer_id
    
    WHERE customers.country = "UK"
    
    GROUP BY customers.company_name; 
    

-- 8. Empresas UK y sus pedidos: 


SELECT 
orders.order_id AS OrderID,
customers.company_name AS Nombre_Cliente, 

orders.order_date AS Fecha_Pedido

FROM customers
JOIN orders on customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY customers.company_name, orders.order_id,
orders.order_date;


-- 9. Ejercicio 9: Empleadas y sus supervisoras: 
-- Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?

 -- falta el 9. Esta se la parte de César 

SELECT * 
FROM employees AS e1, employees AS e2 
WHERE e1.employee_number = e2.reports_to; 

SELECT 
    e1.employee_number AS Numero_Empleado,
    e1.first_name AS Nombre_Empleado,
    e1.last_name AS Apellido_Empleado,
    o1.city AS Ciudad_empleado,
    e2.first_name AS Nombre_supervisor,
    e2.last_name AS Apellido_supervisor,
    o2.city AS Ciudad_supervisor
    
FROM 
    employees AS e1
JOIN
    employees AS e2 ON e1.reports_to = e2.employee_number
JOIN
    offices AS o1 ON e1.office_code = o1.office_code
JOIN
    offices AS o2 ON e2.office_code = o2.office_code;


-- ejercicio 10: Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. 
-- Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe).


SELECT
    orders.order_number AS ID_Pedido,
    customers.customer_name AS Nombre_Empresa,
    orders.order_date AS Fecha_Pedido
FROM orders 
LEFT JOIN customers ON orders.customer_number = customers.customer_number

UNION

SELECT
    orders.order_number AS ID_Pedido,
    customers.customer_name AS Nombre_Empresa,
    orders.order_date AS Fecha_Pedido

FROM orders
RIGHT JOIN customers ON orders.customer_number = customers.customer_number
WHERE orders.order_number IS NULL;


