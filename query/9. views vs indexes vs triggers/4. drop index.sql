-- DROP INDEX [IF EXISTS] index_name;

-- To get all indexes in the current attached database, you use the 
-- following statement:
SELECT
   name, 
   tbl_name, 
   sql
FROM sqlite_master
WHERE type= 'index';


-- Removing indexes
-- Create an index on the name column:
CREATE INDEX customer_firstName
ON customers(FirstName);

-- Create a unique index on the email column:
CREATE UNIQUE INDEX customer_em
ON customers(email);

-- Retrieve all indexes of the current database:
SELECT
   name, 
   tbl_name, 
   sql
FROM sqlite_master
WHERE
   type= 'index';

   
-- Remove Index
DROP INDEX customer_firstName;
DROP INDEX customer_em;


