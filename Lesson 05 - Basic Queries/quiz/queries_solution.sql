-- List all vendor names.  Call the column "Name".  Sort in reverse alphabetical order.
SELECT vend_name AS "Name"
FROM vendors
ORDER BY vend_name DESC;

-- List all columns from the products table. Include only products from vendors 1001 and 1005.
SELECT *
FROM products
WHERE vend_id IN (1001, 1005);

SELECT *
FROM products
WHERE vend_id = 1001
    OR vend_id = 1005;

-- Using the orderitems table display all order_num, but show each order_num only once.  Call the column "Order Numbers".
SELECT DISTINCT order_num AS "Order Numbers"
FROM orderitems;

SELECT order_num
FROM orderitems
UNION
SELECT order_num
FROM orderitems;

-- Display all columns from the products table. Include only the 5 most expensive products ranked from most expensive to least expensive.
SELECT *
FROM products
ORDER BY prod_price DESC
LIMIT 5;

-- Display cust_name, cust_state, and cust_email from the customers table calling the columns "Name", "State", and "Email" respectively.  
-- Include only customers who live in Michigan or Ohio, and have an email address.
SELECT cust_name AS `Name`, cust_state AS `State`, cust_email AS "Email"
FROM customers
WHERE cust_state IN ("MI", "OH") 
    AND cust_email IS NOT NULL;

SELECT cust_name AS `Name`, cust_state AS `State`, cust_email AS "Email"
FROM customers
WHERE (cust_state = "MI"
    OR cust_state = "OH")
    AND cust_email IS NOT NULL;

-- Display prod_id, prod_name, and prod_price from the products table calling the columns "ID", "Name", and "Price" respectively.alter
-- Include only products that are anvils and list them from most to least expensive.
SELECT prod_id AS "ID", prod_name AS "Name", prod_price AS "Price"
FROM products
WHERE prod_name LIKE "%anvil"
ORDER BY prod_price DESC;

SELECT prod_id AS "ID", prod_name AS "Name", prod_price AS "Price"
FROM products
WHERE prod_id LIKE "anv%"
ORDER BY prod_price DESC;

-- From the orderitems table, display the total cost of the ordered product by multiplying the quantity and price.
-- Name the column "line_price"
SELECT quantity * prod_price as "line_price"
FROM orderitems
