-- List all columns from the products table. Include only products from vendors 1001 and 1005.
SELECT *
	FROM products
    WHERE vend_id IN (1001, 1005);
