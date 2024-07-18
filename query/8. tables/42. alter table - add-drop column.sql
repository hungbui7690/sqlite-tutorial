/*
	## Using SQLite ALTER TABLE to add a new column to a table
		
	- You can use the SQLite ALTER TABLE statement to add a new column 
	to an existing table. In this scenario, SQLite appends the new column 
	at the end of the existing column list.
	
	The following illustrates the syntax of ALTER TABLE ADD COLUMN statement:
			ALTER TABLE table_name
			ADD COLUMN column_definition;
			
	- There are some restrictions on the new column:
		+ The new column cannot have a UNIQUE or PRIMARY KEY constraint.
		+ If the new column has a NOT NULL constraint, you must specify 
		a default value for the column other than a NULL value.
		+ The new column cannot have a default of CURRENT_TIMESTAMP, 
		CURRENT_DATE, and CURRENT_TIME, or an expression.
		+ If the new column is a foreign key and the foreign key constraint 
		check is enabled, the new column must accept a default value NULL.

*/

-- 	For example, you can add a new column named location to the equipment table: 
ALTER TABLE equipment 
ADD COLUMN location text;

SELECT * FROM equipment;


/*
	## Using SQLite ALTER TABLE to rename a column
	- SQLite added the support for renaming a column using 
	ALTER TABLE RENAME COLUMN statement in version 3.20.0
	
	- The following shows the syntax of the ALTER TABLE RENAME COLUMN statement:
			ALTER TABLE table_name
			RENAME COLUMN current_name TO new_name;
*/

ALTER TABLE equipment
RENAME COLUMN location TO city;

SELECT * FROM equipment;




/*
	## Using SQLite ALTER TABLE for other actions
	- If you want to perform other actions e.g., drop a column, you 
	use the following steps:
	
	-- 1. disable foreign key constraint check
	PRAGMA foreign_keys=off;

	-- 2. start a transaction
	BEGIN TRANSACTION;

	-- 3. Here you can drop column
	CREATE TABLE IF NOT EXISTS new_table( 
	   column_definition,
	   ...
	);
	
	-- 4. copy data from the table to the new_table
	INSERT INTO new_table(column_list)
	SELECT column_list
	FROM table;

	-- 5. drop the table
	DROP TABLE table;

	-- rename the new_table to the table
	ALTER TABLE new_table RENAME TO table; 

	-- 6. commit the transaction
	COMMIT;

	-- 7. enable foreign key constraint check
	PRAGMA foreign_keys=on;
*/




-- ## SQLite ALTER TABLE DROP COLUMN example
-- SQLite does not support ALTER TABLE DROP COLUMN statement. 
-- To drop a column, you need to use the steps above.
-- The following script creates two tables users and favorites, 
-- and insert data into these tables:
CREATE TABLE users(
	UserId INTEGER PRIMARY KEY,
	FirstName TEXT NOT NULL,
	LastName TEXT NOT NULL,
	Email TEXT NOT NULL,
	Phone TEXT NOT NULL
);
CREATE TABLE favorites(
	UserId INTEGER,
	PlaylistId INTEGER,
	FOREIGN KEY(UserId) REFERENCES users(UserId),
	FOREIGN KEY(PlaylistId) REFERENCES playlists(PlaylistId)
);
INSERT INTO users(FirstName, LastName, Email, Phone)
VALUES('John','Doe','john.doe@example.com','408-234-3456');
INSERT INTO favorites(UserId, PlaylistId)
VALUES(1,1);

SELECT * FROM users;
SELECT * FROM favorites;


-- Suppose, you want to drop the column phone of the users table.
-- First, disable the foreign key constraint check:
PRAGMA foreign_keys=off;

-- Second, start a new transaction:
-- END TRANSACTION;
BEGIN TRANSACTION;

-- Third, create a new table to hold data of the users table except 
-- for the phone column:
CREATE TABLE IF NOT EXISTS persons (
	UserId INTEGER PRIMARY KEY,
	FirstName TEXT NOT NULL,
	LastName TEXT NOT NULL,
	Email TEXT NOT NULL
);

-- Fourth, copy data from the users to persons table:
INSERT INTO persons(UserId, FirstName, LastName, Email)
SELECT UserId, FirstName, LastName, Email 
FROM users;

-- Fifth, drop the users table:
DROP TABLE users;

-- Sixth, rename the persons table to users table:
ALTER TABLE persons RENAME TO users;

-- Seventh, commit the transaction:
COMMIT;

-- Eighth, enable the foreign key constraint check:
PRAGMA foreign_keys=on;

-- Here is the users table after dropping the phone column:
SELECT * FROM users;


/*
	Summary
	- Use the ALTER TABLE statement to modify the structure of an 
	existing table.
	- Use ALTER TABLE table_name RENAME TO new_name statement to 
	rename a table.
	- Use ALTER TABLE table_name ADD COLUMN column_definition statement 
	to add a column to a table.
	- Use ALTER TABLE table_name RENAME COLUMN current_name TO new_name 
	to rename a column.

*/