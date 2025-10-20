-- Display all columns from the products table. Include only the 5 most expensive products ranked from most expensive to least expensive.
SELECT *
	FROM products
    ORDER BY prod_price DESC
    LIMIT 5;