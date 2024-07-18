/*
	- The SQLite DELETE statement allows you to delete one row, multiple rows, and all 
	rows in a table. The syntax of the SQLite DELETE statement is as follows:
		DELETE FROM table
		WHERE search_condition;
	- In this syntax:
		+ First, specify the name of the table which you want to remove rows after the 
		DELETE FROM keywords.
		+ Second, add a search condition in the WHERE clause to identify the rows to 
		remove. The WHERE clause is an optional part of the DELETE statement. If you 
		omit the WHERE clause, the DELETE statement will delete all rows in the table.	
*/


-- create artists backup table
CREATE TABLE artists_backup(
   artistid INTEGER PRIMARY KEY AUTOINCREMENT,
   name NVARCHAR
);
-- populate data from the artists table
INSERT INTO artists_backup 
SELECT artistid,name
FROM artists;




-- (1) The following statement returns all rows from the artists_backup table:
SELECT
	artistid,
	name
FROM artists_backup;


-- (2) We have 280 rows in the artists_backup table.
-- To remove an artist with id 1, you use the following statement:
DELETE FROM artists_backup
WHERE artistid = 1;


-- (3) Because we use artistid to identify the artist, the statement removed exactly 1 row.
-- Suppose you want to delete artists whose names contain the word Santana:
DELETE FROM artists_backup
WHERE name LIKE '%Santana%';
-- There are 9 rows whose values in the name column contain the word Santana therefore, 
-- these 9 rows were deleted.


-- (4) To remove all rows in the artists_backup table, you just need to omit the WHERE 
-- clause as the following statement:
DELETE FROM artists_backup;


