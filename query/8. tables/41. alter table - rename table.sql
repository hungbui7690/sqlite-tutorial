/*
	- Unlike SQL-standard and other database systems, SQLite supports 
	a very limited functionality of the ALTER TABLE statement.

	- By using an SQLite ALTER TABLE statement, you can perform two actions:
		+ Rename a table.
		+ Add a new column to a table.
		+ Rename a column (added supported in version 3.20.0)

			ALTER TABLE existing_table
			RENAME TO new_table;
	
	- These are important points you should know before you rename a table:
		+ The ALTER TABLE only renames a table within a database. You 
		cannot use it to move the table between the attached databases.
		+ The database objects such as indexes and triggers associated 
		with the table will be associated with the new table.
		+ If a table is referenced by views or statements in triggers, you 
		must manually change the definition of views and triggers.
	
*/

-- First, create a table named devices that has three columns: 
-- name, model, serial; and insert a new row into the devices table.
CREATE TABLE devices (
   name TEXT NOT NULL,
   model TEXT NOT NULL,
   Serial INTEGER NOT NULL UNIQUE
);
INSERT INTO devices (name, model, serial)
VALUES('HP ZBook 17 G3 Mobile Workstation','ZBook','SN-2015');

-- Second, use the ALTER TABLE RENAME TO statement to change the 
-- devices table to equipment table as follows:
ALTER TABLE devices
RENAME TO equipment;

-- Third, query data from the equipment table to verify the RENAME 
-- operation.
SELECT name, model, serial
FROM equipment;


