-- (1) The following statement returns the album id and the number of tracks 
-- per album. It uses the GROUP BY clause to groups tracks by album and applies 
-- the COUNT() function to each group.
SELECT
	albumid,
	COUNT(trackid)
FROM tracks
GROUP BY albumid
ORDER BY COUNT(trackid) DESC;


-- (2) You can query data from multiple tables using the INNER JOIN 
-- clause, then use the GROUP BY clause to group rows into a set of summary rows.
-- For example, the following statement joins the tracks table with the albums 
-- table to get the album’s titles and uses the GROUP BY clause with the COUNT 
-- function to get the number of tracks per album.
SELECT
	tracks.albumid,
	title,
	COUNT(trackid)
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY tracks.albumid;



-- (3) To filter groups, you use the GROUP BY with HAVING clause. 
-- For example, to get the albums that have more than 15 tracks, 
-- you use the following statement:
SELECT
	tracks.albumid,
	title,
	COUNT(trackid)
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY tracks.albumid
HAVING COUNT(trackid) > 15;



-- (4) You can use the SUM function to calculate total per group. 
-- For example, to get total length and bytes for each album, you use the 
-- SUM function to calculate total milliseconds and bytes.
SELECT
	albumid,
	SUM(milliseconds) length,
	SUM(bytes) size
FROM tracks
GROUP BY albumid;



-- (5) The following statement returns the album id, album title, maximum length, 
-- minimum length, and the average length of tracks in the tracks table.
SELECT
	tracks.albumid,
	title,
	min(milliseconds),
	max(milliseconds),
	round(avg(milliseconds),2)
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY tracks.albumid;



-- (6) SQLite allows you to group rows by multiple columns.
-- For example, to group tracks by media type and genre, you use the 
-- following statement:
SELECT
   MediaTypeId, 
   GenreId, 
   COUNT(TrackId)
FROM tracks
GROUP BY 
   MediaTypeId, 
   GenreId;
   
   
   
-- (7) The following statement returns the number of invoice by years.
SELECT
   STRFTIME('%Y', InvoiceDate) InvoiceYear, 
   COUNT(InvoiceId) InvoiceCount
FROM invoices
GROUP BY STRFTIME('%Y', InvoiceDate)
ORDER BY InvoiceYear;




