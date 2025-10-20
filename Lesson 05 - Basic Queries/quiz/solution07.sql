-- From the orderitems table, display the total cost of the ordered product by multiplying the quantity and price.
-- Name the column "line_price"
SELECT quantity * prod_price as "line_price"
FROM products
