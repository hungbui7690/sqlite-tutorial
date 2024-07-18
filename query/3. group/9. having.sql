/*
	- You often use the HAVING clause with the GROUP BY clause. 
	The GROUP BY clause groups a set of rows into a set of summary rows or groups. 
	Then the HAVING clause filters groups based on a specified condition.
	- If you use the HAVING clause, you must include the GROUP BY clause
	
	*NOTE* Note that the HAVING clause is applied after GROUP BY 
	clause, whereas the WHERE clause is applied before the GROUP BY clause.
*/


-- (1) To find the number of tracks for each album, you use GROUP BY clause
-- To find the numbers of tracks for the album with id 1, we add 
-- a HAVING clause to the following statement:
SELECT
	AlbumId,
	COUNT(TrackId)
FROM tracks
GROUP BY AlbumId
HAVING AlbumId = 1;	
	
	
	
-- (2) To find albums that have the number of tracks between 18 and 20, 
-- you use the aggregate function in the HAVING clause as shown in the 
-- following statement:
SELECT
   albumid,
   COUNT(trackid)
FROM tracks
GROUP BY albumid
HAVING COUNT(albumid) BETWEEN 18 AND 20
ORDER BY albumid;
	
	
	
-- (3) The following statement queries data from tracks and albums tables 
-- using inner join to find albums that have the total length greater than 
-- 60,000,000 milliseconds.	
SELECT
	tracks.AlbumId,
	title,
	SUM(Milliseconds) AS length
FROM tracks 
INNER JOIN albums ON albums.AlbumId = tracks.AlbumId
GROUP BY tracks.AlbumId 
HAVING length > 60000000;
	
	