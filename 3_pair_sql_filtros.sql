USE northwind; 

SELECT  'Hola!'  AS tipo_nombre
FROM customers;

-- 1. Ciudades que empiezan con A o con B 

SELECT 
city, company_name, contact_name
FROM customers
WHERE city LIKE "A%" or city LIKE "B%";

-- 2. Num de pedidos que han hecho las ciudades que empiezan con L. 

SELECT
customers.city, 
customers.company_name,
customers.contact_name, 
COUNT(customers.customer_id) AS Numero_pedidos

FROM customers 

LEFT JOIN orders ON orders.customer_id = customers.customer_id

GROUP BY customers.city, 
customers.company_name,
customers.contact_name 
HAVING city LIKE "L%";


-- 3. Todos los clientes cuyo "contact_title" no incluya "Sales" 

SELECT 
contact_name,
contact_title, 
company_name

FROM customers 

WHERE contact_title NOT LIKE "%Sales%";

-- 4. que no tengan A en la segunda letra de su nombre: 

SELECT 
contact_name,
contact_title, 
company_name

FROM customers 

WHERE contact_name NOT LIKE "_A%";

-- 5. Extraer toda la información sobre las compañias que tengamos en la BBDD
SELECT 
city,
company_name, 
contact_name,
"supplier" AS Relationship

FROM suppliers

UNION

SELECT 
city,
company_name, 
contact_name,
"customer" AS Relationship
FROM customers; 


-- 6. Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet": 

SELECT *
FROM categories
WHERE description LIKE "%Sweet%" or description LIKE "%sweet%";


-- 7. Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:

SELECT
contact_name, 
"nombre_cliente" AS Categoria
FROM customers 

UNION ALL
SELECT
CONCAT(first_name,last_name) AS Nombre_empleados,
"nombre_empleado" AS Categoria

FROM employees; 

