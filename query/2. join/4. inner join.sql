-- 1. In the tracks table, the AlbumId column is a foreign key. And in the albums 
-- table, the AlbumId is the primary key.
-- To query data from both tracks and albums tables, you use the following statement:
SELECT
	trackid,
	name,
	title
FROM tracks
INNER JOIN albums 
	ON albums.albumid = tracks.albumid;
-- For each row in the tracks table, SQLite uses the value in the albumid column 
-- of the tracks table to compare with the value in the albumid of the albums table. 
-- If SQLite finds a match, it combines data of rows in both tables in the result set.


-- 2. You can include the AlbumId columns from both tables in the final result set 
-- to see the effect.
SELECT
    trackid,
    name,
    tracks.albumid AS album_id_tracks,
    albums.albumid AS album_id_albums,
    title
FROM tracks
INNER JOIN albums 
	ON albums.albumid = tracks.albumid;


-- 3. One track belongs to one album and one album have many tracks. The tracks 
-- table associated with the albums table via albumid column.
--    One album belongs to one artist and one artist has one or many albums. The 
-- albums table links to the artists table via artistid column.
-- 	  To query data from these tables, you need to use two inner join clauses in 
-- the SELECT statement as follows:
SELECT
    trackid,
    tracks.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid;


-- 4. You can use a WHERE clause to get the tracks and albums of the artist with 
-- id 10 as the following statement:
SELECT
	trackid,
	tracks.name AS Track,
	albums.title AS Album,
	artists.name AS Artist
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid
WHERE artists.artistid = 10;










