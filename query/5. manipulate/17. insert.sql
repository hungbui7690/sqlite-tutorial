-- ## Inserting a single row into a table
-- (1) The following statement insert a new row into the artists table:
-- Because the ArtistId column is an auto-increment column, you can ignore 
-- it in the statement. SQLite automatically geneate a sequential integer 
-- number to insert into the ArtistId column.
INSERT INTO artists (name)
VALUES('Bud Powell');


-- (2) You can verify the insert operation by using the following SELECT statement:
SELECT ArtistId, Name
FROM Artists
ORDER BY ArtistId DESC
LIMIT 1;



-- ## Inserting multiple rows into a table
-- (3) The following example inserts three rows into the artists table:
INSERT INTO artists (name) VALUES
	("Buddy Rich"),
	("Candido"),
	("Charlie Byrd");
	
-- (4) Verify
SELECT ArtistId, Name
FROM artists 
ORDER BY ArtistId DESC
LIMIT 3; 



-- ## Inserting default values
/*
- When you create a new table using the CREATE TABLE statement, 
you can specify default values for columns, or a NULL if a default value 
is not specified.
- The third form of the INSERT statement is INSERT DEFAULT VALUES, which 
inserts a new row into a table using the default values specified in 
the column definition or NULL if the default value is not available 
and the column does not have a NOT NULL constraint.
*/
-- (5) For example, the following statement inserts a new row into 
-- the artists table using INSERT DEFAULT VALUES:
INSERT INTO artists DEFAULT VALUES;


-- (6) Verify: 
-- The default value of the ArtistId column is the next sequential 
-- integer . However, the name column does not have any default value, 
-- therefore, the INSERT DEFAULT VALUES statement inserts NULL into it.
SELECT ArtistId, Name
FROM artists
ORDER BY ArtistId DESC;


-- ## Inserting new rows with data provided by a SELECT statement
-- (7) Suppose you want to backup the artists table, you can follow 
-- these steps:
-- First, create a new table named artists_backup as follows:
CREATE TABLE artists_backup(
   ArtistId INTEGER PRIMARY KEY AUTOINCREMENT,
   Name NVARCHAR
);
-- (8) To insert data into the artists_backup table with the data from 
-- the artists table, you use the INSERT INTO SELECT statement as follows:
INSERT INTO artists_backup 
SELECT ArtistId, Name
FROM artists;

-- (9) If you query data from the artists_backup table, you will see all 
-- data in the artists table.
SELECT * FROM artists_backup;