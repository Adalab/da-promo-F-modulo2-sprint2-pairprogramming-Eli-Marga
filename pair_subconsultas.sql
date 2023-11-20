USE northwind;
/*1.Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.
Los resultados de esta query serán*/

SELECT MAX(ord1.order_date),ord1.customer_id,ord1.employee_id,ord1.required_date,ord1.order_id
FROM orders AS ord1
WHERE ord1.order_date =
(SELECT MAX(ord2.order_date)
FROM orders AS ord2
WHERE ord1.employee_id=ord2.employee_id)
GROUP BY ord1.customer_id,ord1.employee_id,ord1.required_date,ord1.order_id;
/*2.Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas.
Los resultados deberán ser:*/
SELECT MAX(ord_details1.unit_price),ord_details1.product_id
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
SELECT p.product_id,p.product_name,p.category_id
FROM products AS p
WHERE p.category_id=
(SELECT c.category_id
FROM categories AS c
WHERE c.category_name= "Beverages");

/*4.Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país*/

SELECT distinct country
FROM customers
WHERE country NOT IN (SELECT DISTINCT country
        FROM suppliers
        WHERE country IS NOT NULL);
        
/*5.Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"*/
/*Extraed el OrderId y el nombre del cliente que pidieron */
/*más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.*/
SELECT DISTINCT country
FROM customers
WHERE country NOT IN (SELECT DISTINCT country
        FROM suppliers
        WHERE country IS NOT NULL);

/*6.Extraed los 10 productos más caros*/
/*Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.*/

SELECT product_name, unit_price
from products as pr
where product_name = (SELECT product_name
from products as pr1 where pr.product_name = pr1.product_name)
order by unit_price DESC
limit 10;


