-- Using the orderitems table display all order_num, but show each order_num only once.  Call the column "Order Numbers".
SELECT DISTINCT order_num as "Order Numbers"
	FROM orderitems;