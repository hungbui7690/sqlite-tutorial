/*
	- A subquery is a SELECT statement nested in another statement. 
	- You must use a pair of parentheses to enclose a subquery. Note that you 
can nest a subquery inside another subquery with a certain depth.
	- Typically, a subquery returns a single row as an atomic value, though 
it may return multiple rows for comparing values with the "IN" operator.
	- You can use a subquery in the SELECT, FROM, WHERE, and JOIN clauses.
*/


-- (1) You can use a simple subquery as a search condition. 
-- For example, the following statement returns all the tracks in 
-- the album with the title  Let There Be Rock
SELECT trackid,
       name,
       albumid
FROM tracks
WHERE albumid = (
   SELECT albumid
   FROM albums
   WHERE title = 'Let There Be Rock'
);
/*
- The subquery returns the id of the album with the title 'Let There 
Be Rock'. The query uses the equal operator (=) to compare albumid 
returned by the subquery with the  albumid in the tracks table.
- If the subquery returns multiple values, you can use the IN 
operator to check for the existence of a single value against a set 
of value.
*/



-- (2) the following query returns the customers whose sales representatives 
-- are in Canada.
SELECT customerid,
       firstname,
       lastname
FROM customers
WHERE supportrepid IN (
		SELECT employeeid
		FROM employees
		WHERE country = 'Canada' -- return multi values
	);
	
	
	
-- (3) NOT VALID: Sometimes you want to apply aggregate functions to a 
-- column multiple times. For example, first, you want to sum 
-- the size of an album and then calculate the average size of 
-- all albums. You may come up with the following query.
SELECT AVG(SUM(bytes) 
FROM tracks
GROUP BY albumid;
	
-- (4) To fix it, you can use a subquery in the FROM clause as follows:
SELECT AVG(album.size)
FROM (
	SELECT SUM(bytes) SIZE
	FROM tracks
	GROUP BY albumid
) AS album;



/*
	- All the subqueries you have seen so far can be executed 
	independently. In other words, it does not depend on the outer query.
	- The correlated subquery is a subquery that uses the values from 
	the outer query. Unlike an ordinal subquery, a correlated subquery 
	cannot be executed independently.
	- The correlated subquery is not efficient because it is evaluated 
	for each row processed by the outer query.
*/


-- (5) The following query uses a correlated subquery to return the 
-- albums whose size is less than 10MB.
SELECT albumid,
       title
FROM albums
WHERE 10000000 > (
	SELECT sum(bytes) 
	FROM tracks
	WHERE tracks.AlbumId = albums.AlbumId)
ORDER BY title;
/*
- For each row processed in the outer query, the correlated subquery 
calculates the size of the albums from the tracks that belong the 
current album using the SUM function.
- The predicate in the WHERE clause filters the albums that have 
the size greater than or equal 10MB (10000000 bytes).
*/




-- (6) The following query uses a correlated subquery in the SELECT 
-- clause to return the number of tracks in an album.
SELECT albumid,
       title,
       (
           SELECT count(trackid) 
           FROM tracks
           WHERE tracks.AlbumId = albums.AlbumId
       ) as tracks_count
FROM albums
ORDER BY tracks_count DESC;




