-- ## SQLite ALTER TABLE RENAME COLUMN example
-- Let’s take an example of using the ALTER TABLE RENAME COLUMN statement.



-- First, create a new table called Locations:
CREATE TABLE Locations(
	LocationId INTEGER PRIMARY KEY,
	Address TEXT NOT NULL,
	City TEXT NOT NULL,
	State TEXT NOT NULL,
	Country TEXT NOT NULL
);

-- Second, insert a new row into the Locations table by using the 
-- INSERT statement:
INSERT INTO Locations(Address,City,State,Country)
VALUES('3960 North 1st Street','San Jose','CA','USA');

-- Third, rename the column Address to Street by using the 
-- ALTER TABLE RENAME COLUMN statement:
ALTER TABLE Locations
RENAME COLUMN Address TO Street;

-- Fourth, query data from the Locations table:
SELECT * FROM Locations;

-- Finally, show the schema of the Locations table:
PRAGMA table_info('Locations');





/*
	## The old way to rename column
	- SQLite did not support the ALTER TABLE RENAME COLUMN syntax before 
	version 3.25.0.

	- If you’re using the SQLite with the version lower than 3.25.0 and 
	could not upgrade, then you should follow these steps to rename a column:

		+ First, start a transaction.
		+ Second, create a new table whose structure is the same as the original one except for the column that you want to rename.
		+ Third, copy data from the original table to the new table.
		+ Fourth, drop the original table.
		+ Fifth, rename the new table to the original table.
		+ Finally, commit the transaction.
		
*/
	
-- Renaming column example
-- The following statement recreates the Locations table:
DROP TABLE IF EXISTS Locations;
CREATE TABLE Locations(
	LocationId INTEGER PRIMARY KEY,
	Address TEXT NOT NULL,
	State TEXT NOT NULL,
	City TEXT NOT NULL,
	Country TEXT NOT NULL
);

-- And this INSERT statement inserts a new row into the Locations table:
INSERT INTO Locations(Address,City,State,Country)
VALUES('3960 North 1st Street','San Jose','CA','USA');

-- Suppose that you want to the change the column Address to Street.
-- First, start a new transaction:
BEGIN TRANSACTION;

-- Second, create a new table called LocationsTemp with the same structure 
-- as the Locations table except for the Address column:
CREATE TABLE LocationsTemp(
	LocationId INTEGER PRIMARY KEY,
	Street TEXT NOT NULL,
	City TEXT NOT NULL,
	State TEXT NOT NULL,
	Country TEXT NOT NULL
);

-- Third, copy data from the table Locations to LocationsTemp:
INSERT INTO LocationsTemp(Street,City,State,Country)
SELECT Address,City,State,Country
FROM Locations;

-- Fourth, drop the Locations table:
DROP TABLE Locations;

-- Fifth, rename the table LocationsTemp to Locations:
ALTER TABLE LocationsTemp 
RENAME TO Locations;

-- Finally, commit the transaction:
COMMIT;

-- If you query the Locations table, you will see that the column Address has been renamed to Street:
SELECT * FROM Locations;