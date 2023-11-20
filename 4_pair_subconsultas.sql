USE northwind;

/*1.Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.
Los resultados de esta query serán*/

SELECT MAX(ord1.order_date) AS "Date Max of order",ord1.customer_id AS "Client's ID",ord1.employee_id AS "Employee's ID",ord1.required_date AS "Required Date",ord1.order_id AS "Order ID"
FROM orders AS ord1
WHERE ord1.order_date =
(SELECT MAX(ord2.order_date)
FROM orders AS ord2
WHERE ord1.employee_id=ord2.employee_id)
GROUP BY ord1.customer_id,ord1.employee_id,ord1.required_date,ord1.order_id;

/*2.Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas.
Los resultados deberán ser:*/

SELECT MAX(ord_details1.unit_price) AS "Price per unit" ,ord_details1.product_id AS "Product ID"
FROM order_details AS ord_details1
WHERE unit_price = 
(SELECT MAX(ord_details2.unit_price)
FROM order_details AS ord_details2
WHERE ord_details1.product_id= ord_details2.product_id)
GROUP BY ord_details1.unit_price, ord_details1.product_id;

/*3.Extraed información de los productos "Beverages"*/
/*En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. */
/*En concreto, tienen especial interés por los productos con categoría "Beverages". */
/*Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/

SELECT p.product_id AS "Product ID",p.product_name AS "Name",p.category_id AS "Category"
FROM products AS p
WHERE p.category_id=
(SELECT c.category_id
FROM categories AS c
WHERE c.category_name= "Beverages");

/*4.Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país*/

SELECT distinct country AS "Client's Country"
FROM customers
WHERE country NOT IN (SELECT DISTINCT country
        FROM suppliers
        WHERE country IS NOT NULL);
        
/*5.Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"*/
/*Extraed el OrderId y el nombre del cliente que pidieron */
/*más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.*/

SELECT orders.customer_id AS "ID client", customers.company_name AS "Company Name", order_details.order_id AS "Order ID", order_details.quantity AS "Quantity"
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id
JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_details.product_id = 6 
AND order_details.quantity > 20;


/*6.Extraed los 10 productos más caros*/
/*Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT product_name AS "Name", unit_price AS "Price per unit"
FROM products as pr
WHERE product_name = (SELECT product_name
FROM products as pr1 where pr.product_name = pr1.product_name)
ORDER BY unit_price DESC
LIMIT 10;

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


