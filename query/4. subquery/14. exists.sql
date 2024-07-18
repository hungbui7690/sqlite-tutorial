/*
	 - The EXISTS operator is a logical operator that checks whether a subquery returns any row.
	 - If the subquery returns one or more row, the EXISTS operator return true. 
	   > Otherwise, the EXISTS operator returns false or NULL.
*/




-- (1) The following statement finds customers who have invoices:
SELECT
    CustomerId,
    FirstName,
    LastName,
    Company
FROM Customers c
WHERE EXISTS (
	SELECT 1 -- 1 means true 
	FROM Invoices
	WHERE CustomerId = c.CustomerId
    )
ORDER BY 
    FirstName,
    LastName; 
	
	
	
-- (2) Notice that you can use the IN operator instead of EXISTS operator in 
-- this case to achieve the same result:
SELECT
   CustomerId, 
   FirstName, 
   LastName, 
   Company
FROM Customers c
WHERE CustomerId IN (
  SELECT CustomerId
  FROM Invoices
   )
ORDER BY
   FirstName, 
   LastName;
/*
	Once the subquery returns the first row, the EXISTS operator stops searching 
because it can determine the result. On the other hand, the IN operator must scan 
all rows returned by the subquery to determine the result.
	Generally speaking, the EXISTS operator is faster than IN operator if the result 
set returned by the subquery is large. By contrast, the IN operator is faster than 
the EXISTS operator if the result set returned by the subquery is small.
*/



-- (2) This query find all artists who do not have any album in the Albums table:
SELECT *
FROM Artists a
WHERE NOT EXISTS(
  SELECT 1
  FROM Albums
  WHERE ArtistId = a.ArtistId
   )
ORDER BY Name;




