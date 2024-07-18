/*
	- If you come from other database systems such as MySQL and PostgreSQL, you’ll 
	notice that they use "static typing".
	- This means that when you declare a column with a specific data type, that 
	column can store only data of the declared type.
	- Unlike other database systems, SQLite uses a "dynamic type system". 
	- In other words, the data type of a column is determined by the value stored 
	in it, rather than by the column’s declared data type.
	
	- In addition, you don’t have to declare a specific data type for a column 
	when creating a table.
	- For example, if you declare a column with the integer data type, you can 
	still store various data types like text and BLOB without issues.
	- SQLite provides five primitive data types, commonly referred to as storage classes.
	- Storage classes describe the formats that SQLite uses to store data on disk. 
	A storage class is more general than a data type; for example, the INTEGER storage 
	class includes six different integer types. In many cases, you can use storage 
	classes and data types interchangeably.
	- The following table illustrates five storage classes in SQLite:
		Storage Class	Meaning
		NULL			NULL values mean missing information or unknown.
		INTEGER			Integer values are whole numbers (either positive or negative). 
						An integer can have variable sizes such as 1, 2,3, 4, or 8 bytes.
		REAL			Real values are real numbers with decimal values that use 
						8-byte floats.
		TEXT			TEXT is used to store character data. The maximum length of TEXT 
						is unlimited. SQLite supports various character encodings.
		BLOB			BLOB stands for a binary large object that can store any kind of 
						data. Theoretically, the maximum size of BLOB is unlimited.
						
	- SQLite determines the data type of a value based on its data type according to 
	the following rules:
		+ If a literal has no enclosing quotes and decimal point or exponent, SQLite 
		assigns the REAL storage class.
		+ If a literal is enclosed by single or double quotes, SQLite assigns the TEXT 
		storage class.
		+ If a literal has no quotes, no decimal point, and no exponent, SQLite assigns 
		the INTEGER storage class.
		+ If a literal is NULL without quotes, SQLite assigns the NULL storage class.
		+ If a literal has a prefix X’…’, SQLite assigns the BLOB storage class.
		
	**NOTE** SQLite does not support built-in date and time storage classes. 
	However, you can use the TEXT, INT, or REAL to store date and time values. 
	For detailed information on handling date and time values, check out the 
	SQLite date and time tutorial.
*/

-- SQLite provides the typeof() function that allows you to check the storage class 
-- of a value based on its format. See the following example:
SELECT
  TYPEOF(100),
  TYPEOF(10.0),
  TYPEOF('100'),
  TYPEOF(x'1000'),
  TYPEOF(NULL);



-- A single column in SQLite can store mixed data types
CREATE TABLE test_datatypes (
   id INTEGER PRIMARY KEY, 
   val
);
INSERT INTO test_datatypes (val) VALUES
  (1), (2), (10.1), (20.5), ('A'),
  ('B'), (NULL), (x'0010'), (x'0011');
  
  
-- use the typeof() function to get the data type of each value stored 
-- in the val column.
SELECT id, val, typeof (val)
FROM test_datatypes;