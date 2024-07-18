/*
	- The idea of the REPLACE statement is that when a UNIQUE or PRIMARY KEY 
	constraint violation occurs, it does the following:
		+ First, delete the existing row that causes a constraint violation.
		+ Second, insert a new row.
	- In the second step, if any constraint violation e.g., NOT NULL constraint occurs, 
	the REPLACE statement will abort the action and roll back the transaction.
	- The following illustrates the syntax of the REPLACE statement.
			INSERT OR REPLACE INTO table(column_list)
			VALUES(value_list);
*/

CREATE TABLE IF NOT EXISTS positions (
	id INTEGER PRIMARY KEY,
	title TEXT NOT NULL,
	min_salary NUMERIC
);
INSERT INTO positions (title, min_salary) VALUES 
	('DBA', 120000),
    ('Developer', 100000),
    ('Architect', 150000);
	
SELECT * FROM positions;


-- The following statement creates a unique index on the title column of 
-- the positions table to ensure that it doesn’t have any duplicate position title:
CREATE UNIQUE INDEX idx_positions_title 
ON positions (title);




-- ///////////////////////////////
-- (1) Suppose, you want to add a position into the positions table if it 
-- does not exist, in case the position exists, update the current one.
-- The following REPLACE statement inserts a new row into the positions 
-- table because the position title Full Stack Developer is not in the 
-- positions table.
REPLACE INTO positions (title, min_salary)
VALUES('Full Stack Developer', 140000);

-- The query will update "DBA" because it exists in the positions table
REPLACE INTO positions (title, min_salary)
VALUES('DBA', 170000);

SELECT * FROM positions;
/*
	- First, SQLite checked the UNIQUE constraint.
	- Second, because this statement violated the UNIQUE constraint by 
	trying to add the DBA title that already exists, SQLite deleted 
	the existing row.
	- Third, SQLite inserted a new row with the data provided by the 
	REPLACE statement.
	- Notice that the REPLACE statement means INSERT or REPLACE, not 
	INSERT or UPDATE.
*/




-- (2) What the statement tried to do is to update the min_salary for the 
-- position with id 2, which is the developer.
-- First, the position with id 2 already exists, the REPLACE statement removes it.
-- Then, SQLite tried to insert a new row with two columns: ( id, min_salary). 
-- However, it violates the NOT NULL constraint of the title column. Therefore, 
-- SQLite rolls back the transaction.
-- If the title column does not have the NOT NULL constraint, the REPLACE 
-- statement will insert a new row whose the title column is NULL.
REPLACE INTO positions (id, min_salary)
VALUES(2, 110000);
