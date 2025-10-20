-- Display prod_id, prod_name, and prod_price from the products table calling the columns "ID", "Name", and "Price" respectively.alter
-- Include only products that are anvils and list them from most to least expensive.
SELECT prod_id as "ID", prod_name as "Name", prod_price as "Price"
	FROM products
    WHERE prod_name LIKE "%anvil"
    ORDER BY prod_price DESC;
