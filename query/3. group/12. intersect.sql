/*
	- SQLite INTERSECT operator allows you to combine the result sets of two 
	queries and returns distinct rows that appear in both result sets of the queries.
	
	- The basic rules for combining the result sets of two queries are as follows:
		+ First, the number and the order of the columns in all queries must be the same.
		+ Second, the data types must be comparable.
*/



-- (1) Intersect = Intersect + Distince > remove duplications
SELECT c1 FROM t1
INTERSECT
SELECT c2 FROM t2;


-- (2) The following statement uses the INTERSECT operator to find 
-- customers who have invoices:
SELECT CustomerId, FirstName, LastName
FROM customers
INTERSECT
SELECT CustomerId, FirstName, LastName
FROM invoices
INNER JOIN customers USING (CustomerId)
ORDER BY CustomerId;