/*
	- A primary key is a column or group of columns used to identify the 
	uniqueness of rows in a table. Each table has one and only one primary key.
	
	- Syntax: 
		CREATE TABLE table_name(
		   column_1 INTEGER NOT NULL PRIMARY KEY,
		   ...
		);
		
	- Second, in case primary key consists of two or more columns, you use 
	the PRIMARY KEY table constraint to define the primary as shown in the 
	following statement.

		CREATE TABLE table_name(
		   column_1 INTEGER NOT NULL,
		   column_2 INTEGER NOT NULL,
		   ...
		   PRIMARY KEY(column_1,column_2,...)
		);	
		
	- In SQL standard, the primary key column must not contain NULL values. 
	It means that the primary key column has an implicit NOT NULL constraint.
	- However, to make the current version of SQLite compatible with the 
	earlier version, SQLite allows the primary key column to contain NULL values.	
		
	- WITHOUT ROWID option:
		+ if we add this option, then SQLite adds an implicit column 
		called "rowid"
	
*/


-- 1 column
CREATE TABLE languages (
   language_id INTEGER,
   name TEXT NOT NULL,
   PRIMARY KEY (language_id)
);

-- 2 columns 
CREATE TABLE country_languages (
	country_id INTEGER NOT NULL,
	language_id INTEGER NOT NULL,
	PRIMARY KEY (country_id, language_id),
	FOREIGN KEY (country_id) REFERENCES countries (country_id) 
            ON DELETE CASCADE ON UPDATE NO ACTION,
	FOREIGN KEY (language_id) REFERENCES languages (language_id) 
            ON DELETE CASCADE ON UPDATE NO ACTION
);


-- Unlike other database systems e.g., MySQL and PostgreSQL, you cannot use 
-- the ALTER TABLE statement to add a primary key to an existing table.
/*
	You need to follow these steps to work around the limitation:
	- First, set the foreign key constarint check off.
	- Next, rename the table to another table name (old_table)
	- Then, create a new table (table) with exact structure of the 
	table that you have been renamed.
	- After that, copy data from the old_table to the table.
	- Finally, turn on the foreign key constraint check on
		PRAGMA foreign_keys=off;
		BEGIN TRANSACTION;
		ALTER TABLE table RENAME TO old_table;
		CREATE TABLE newTable();
		INSERT INTO newTable SELECT * FROM old_table;
		COMMIT;
		PRAGMA foreign_keys=on;
	- The BEGIN TRANSACTION starts a new transaction. It ensures that 
	all subsequent statements execute successfully or nothing executes 
	at all.
*/


-- Let’s create a table name cities without a primary key.
CREATE TABLE cities (
   id INTEGER NOT NULL,
   name text NOT NULL
);
INSERT INTO cities (id, name)
VALUES(1, 'San Jose');

-- In order to add the primary key to the cities table, you perform 
-- the following steps:
PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
ALTER TABLE cities RENAME TO old_cities;
CREATE TABLE cities (
   id INTEGER NOT NULL PRIMARY KEY,
   name TEXT NOT NULL
);
INSERT INTO cities 
SELECT * FROM old_cities;
DROP TABLE old_cities;
COMMIT;
PRAGMA foreign_keys=on;


-- If you use SQLite GUI tool, you can use the following statement to 
-- show the table’s information.
PRAGMA table_info([cities]);
