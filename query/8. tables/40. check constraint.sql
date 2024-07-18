/*
	- SQLite CHECK constraints allow you to define expressions to test values 
	whenever they are inserted into or updated within a column.
	- If the values do not meet the criteria defined by the expression, SQLite 
	will issue a constraint violation and abort the statement.
	- The CHECK constraints allow you to define additional data integrity checks 
	beyond UNIQUE or NOT NULL to suit your specific application.
	- SQLite allows you to define a CHECK constraint at the column level or the 
	table level.

	- The following statement shows how to define a CHECK constraint at 
	the column level:
			CREATE TABLE table_name(
				column_name data_type CHECK(expression),
			);
	
	- and the following statement illustrates how to define a CHECK constraint 
	at the table level:
			CREATE TABLE table_name(
				CHECK(expression)
			);	
	
	- In this syntax, whenever a row is inserted into a table or an existing 
	row is updated, the expression associated with each CHECK constraint 
	is evaluated and returned a numeric value 0 or 1.
	- If the result is zero, then a constraint violation occurred. If the 
	result is a non-zero value or NULL, it means no constraint violation occurred.

	- Note that the expression of a CHECK constraint cannot contain a subquery.

*/



-- ## Using SQLite CHECK constraint at the column level example
-- The following statement creates a new table named contacts:
DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
    contact_id INTEGER PRIMARY KEY,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    email      TEXT,
    phone      TEXT    NOT NULL
	CHECK (length(phone) >= 10) 
);
INSERT INTO contacts(first_name, last_name, phone)
VALUES('John','Doe','408123456'); -- error

-- The following statement should work because the value in the 
-- phone column has 13 characters, which satisfies the expression 
-- in the CHECK constraint:
INSERT INTO contacts(first_name, last_name, phone)
VALUES('John','Doe','(408)-123-456');




-- ## Using SQLite CHECK constraints at the table level example
-- The following statement creates a new table named products:
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id   INTEGER         PRIMARY KEY,
    product_name TEXT            NOT NULL,
    list_price   DECIMAL (10, 2) NOT NULL,
    discount     DECIMAL (10, 2) NOT NULL
                                DEFAULT 0,
    CHECK (
		list_price >= discount AND -- HERE
        discount >= 0 AND 
        list_price >= 0
		) 
);

-- The following statement violates the CHECK constraint because the 
-- discount is higher than the list price.
INSERT INTO products(product_name, list_price, discount)
VALUES('New Product',900,1000); -- ERROR  

-- The following statement also violates the CHECK constraint because 
-- the discount is negative:
INSERT INTO products(product_name, list_price, discount)
VALUES('New XFactor',1000,-10); -- ERROR


/*
	## Adding CHECK constraints to an existing table
	- As of version 3.25.2, SQLite does not support adding a CHECK constraint 
	to an existing table.
	- However, you can follow these steps:
	  + First, create a new table whose structure is the same as the table 
	that you want to add a CHECK constraint. The new table should also include 
	the CHECK constraint:
			CREATE TABLE new_table (
				[...],
				CHECK ([...])
			);
	- To get the structure of the old table, you can use the .schema command. 
	- Check out the "SQLite DESCRIBE" table tutorial for more information.
	
	- Second, copy data from the old table to the new table.
			INSERT INTO new_table SELECT * FROM old_table;
	
	- Third, drop the old table:
			DROP TABLE old_table;

	- Fourth, rename the new table to the old one:
			ALTER TABLE new_table RENAME TO old_table;
	
	- To make all statements above transaction-safe, you should execute 
	all of them within a transaction like this:
			BEGIN;
			CREATE TABLE new_table (
				[...],
				CHECK ([...])
			);
			INSERT INTO new_table SELECT * FROM old_table;
			DROP TABLE old_table;	
			ALTER TABLE new_table RENAME TO old_table;
			COMMIT;
*/
