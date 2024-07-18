/*
	NOT NULL Constraint
	- When you create a table, you can specify whether a column 
	accepts NULL values or not. By default, all columns in a 
	table accept NULL values except you explicitly use 
	NOT NULL constraints.
	- To define a NOT NULL constraint for a column, you use the 
	following syntax:
	
		CREATE TABLE table_name (
			column_name type_name NOT NULL,
		);	
	
	- Unlike other constraints such as PRIMARY KEY and CHECK, you 
	can only define NOT NULL constraints at the column level, not 
	the table level.
	- Based on the SQL standard, PRIMARY KEY should always imply 
	NOT NULL. However, SQLite allows NULL values in the PRIMARY KEY 
	column except that a column is INTEGER PRIMARY KEY column or 
	the table is a WITHOUT ROWID table or the column is defined as 
	a NOT NULL column.
	- This is due to a bug in some early versions. If this bug 
	is fixed to conform with the SQL standard, then it might break 
	the legacy systems. Therefore, it has been decided to allow 
	NULL values in the  PRIMARY KEY column.
	- Once a NOT NULL constraint is attached to a column, any 
	attempt to set the column value to NULL such as inserting 
	or updating will cause a constraint violation.
	
*/

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(
    supplier_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL -- here
);

INSERT INTO suppliers(name)
VALUES(NULL); -- error