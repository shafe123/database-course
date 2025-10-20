-- List all vendor names.  Call the column "Name".  Sort in reverse alphabetical order.
SELECT vend_name as "Name"
	FROM vendors
    ORDER BY vend_name DESC;