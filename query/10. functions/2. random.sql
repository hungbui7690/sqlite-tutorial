-- The SQLite random() function returns a random integer between 
-- -9223372036854775808 and +9223372036854775807.

-- The following statement uses the random() function to return a 
random integer.
SELECT random();

-- If the number of rows in a table is small, you can use the 
-- random() function to get a number of random rows.
-- For example, the following example uses the random() function 
-- to retrieve 5 random albums from the albums table:
SELECT title 
FROM albums
ORDER BY random() 
LIMIT 5;


