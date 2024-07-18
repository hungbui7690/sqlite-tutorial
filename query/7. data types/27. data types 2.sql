/*
	- You may ask how SQLite sorts data in a column with different storage classes 
	like val column above.
	- To resolve this, SQLite provides the following set of rules when it comes to 
	sorting:
		+ NULL storage class has the lowest value. It is lower than any other 
		value. Between NULLs, there is no order.
		+ The next higher storage classes are INTEGER and REAL. SQLite compares 
		INTEGER and REAL numerically.
		+ The next higher storage class is TEXT. SQLite uses the collation of 
		TEXT values when comparing the TEXT values.
		+ The highest storage class is the BLOB. SQLite uses the C function 
		memcmp() to compare BLOB values.
			
	- When you use the ORDER BY clause to sort the data in a column with 
	different storage classes, SQLite performs the following steps:
		+ First, group values based on storage class: NULL, INTEGER, and REAL, 
		TEXT, and BLOB.
		+ Second, sort the values in each group.
*/

-- (1) The following statement sorts the mixed data in the val column of 
-- the test_datatypes table:
SELECT id, val, typeof (val)
FROM test_datatypes
ORDER BY val;


/*
	SQLite manifest typing & type affinity
	- Other important concepts related to SQLite data types are manifest typing 
	and type affinity:
		+ Manifest typing means that a data type is a property of a value stored 
		in a column, rather than a property of the column itself. SQLite uses 
		manifest typing to store values of any type in a column.
		+ Type affinity of a column refers to the recommended type for data stored 
		in that column. Please note that this is a recommendation rather than an 
		enforcement. Therefore, a column can store values of any type.
*/

/*
	Summary
	- SQLite uses a dynamic type system in which you can store a value of any 
	type in a column.
	- SQLite offers five storage classes including INTEGER, REAL, TEXT, 
	BLOB, and NULL.
	- Use the typeof() function to check the storage class of a value.
	- Manifest typing means a data type is an attribute of a value rather 
	than a property of a table column.
	- Type affinity refers to the recommended type of a column.
*/
