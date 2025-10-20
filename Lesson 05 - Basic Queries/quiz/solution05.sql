-- Display cust_name, cust_state, and cust_email from the customers table calling the columns "Name", "State", and "Email" respectively.  
-- Include only customers who live in Michigan or Ohio, and have an email address.
SELECT cust_name as `Name`, cust_state as `State`, cust_email as "Email"
	FROM customers
    WHERE cust_state IN ("MI", "OH") and cust_email is NOT NULL;