
USE northwind; 
-- 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
-- Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
-- Para eso nos pide que lo hagamos con una query correlacionada.

SELECT
    orders.employee_id AS "ID employee",
    orders.order_date AS "Max order date"
FROM orders
WHERE orders.order_date = (
    SELECT MAX(o.order_date)
    FROM orders o
    WHERE o.employee_id = orders.employee_id
);


-- 2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.
-- Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
-- De nuevo lo tendréis que hacer con queries correlacionadas.

SELECT products.product_id AS "ID product", products.product_name "Name", orders.max_unit_price "Max price"
FROM products
JOIN (SELECT product_id, MAX(unit_price) AS max_unit_price
	  FROM order_details
	  GROUP BY product_id
	) orders ON products.product_id = orders.product_id;

-- 3. Extraed información de los productos "Beverages"
-- En concreto, tienen especial interés por los productos con categoría "Beverages". 
-- Devuelve el ID del producto, el nombre del producto y su ID de categoría.

SELECT product_id AS "Id product", product_name AS "Name", category_id AS "Category"
FROM products
WHERE category_id = (
    SELECT category_id
    FROM categories
    WHERE category_name = 'Beverages'
);


-- 4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
-- Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, 
-- entonces podría dirigirse a estos países para buscar proveedores adicionales.

SELECT DISTINCT customers.country AS "Client's Country"
FROM customers
WHERE customers.country NOT IN (
    SELECT DISTINCT suppliers.country
    FROM suppliers
);

-- 5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
-- Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" 
-- (ProductID 6) en un solo pedido.

SELECT orders.customer_id AS "ID client", customers.company_name AS "Company Name", order_details.order_id AS "Order ID", order_details.quantity AS "Quantity"
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id
JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_details.product_id = 6 
AND order_details.quantity > 20;


-- 6. Extraed los 10 productos más caros
-- Nos siguen pidiendo más queries correlacionadas. 
-- En este caso queremos saber cuáles son los 10 productos más caros.

SELECT product_id AS "ID product", product_name AS "Name", unit_price AS "Price per unit"
FROM products p1
WHERE 10 > (
    SELECT COUNT(DISTINCT p2.unit_price)
    FROM products p2
    WHERE p2.unit_price > p1.unit_price
);

-- 7. Qué producto es más popular
-- Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.

SELECT 
    order_details.product_id AS "ID product",
    products.product_name AS "Name",
    SUM(order_details.quantity) AS "Sold Q Total"
FROM 
    order_details
JOIN 
    products ON order_details.product_id = products.product_id
GROUP BY 
    order_details.product_id, products.product_name
ORDER BY 
    SUM(order_details.quantity)DESC
LIMIT 1;
