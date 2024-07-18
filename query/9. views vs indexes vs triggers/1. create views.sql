/*
	What is a view
	- In database theory, a view is a result set of a stored query. A view is 
	the way to pack a query into a named object stored in the database.

	- You can access the data of the underlying tables through a view. The 
	tables that the query in the view definition refers to are called base tables.

	- A view is useful in some cases:
		+ First, views provide an abstraction layer over tables. You can add and 
		remove the columns in the view without touching the schema of the 
		underlying tables.
		+ Second, you can use views to encapsulate complex queries with joins 
		to simplify the data access.
		
	- SQLite view is read only. It means you cannot use INSERT, DELETE, and  UPDATE statements to update data in the base tables through the view.
	
	- Syntax: To create a view, you use the CREATE VIEW statement as follows:
			CREATE [TEMP] VIEW [IF NOT EXISTS] view_name[(column-name-list)]
			AS 
			   select-statement;
		+ First, specify a name for the view. The IF NOT EXISTS option only 
		creates a new view if it doesn’t exist. If the view already exists, it 
		does nothing.
		+ Second, use the the TEMP or TEMPORARY option if you want the view to 
		be only visible in the current database connection. The view is called 
		a temporary view and SQLite automatically removes the temporary view 
		whenever the database connection is closed.
		+ Third, specify a  SELECT statement for the view. By default, the 
		columns of the view derive from the result set of the SELECT statement. 
		However, you can assign the names of the view columns that are different 
		from the column name of the table
				   
*/

-- ## Creating a view to simplify a complex query
-- The following query gets data from the tracks, albums, media_types and 
-- genres tables in the sample database using the inner join clause.
SELECT
   trackid,
   tracks.name,
   albums.Title AS album,
   media_types.Name AS media,
   genres.Name AS genres
FROM tracks
INNER JOIN albums ON Albums.AlbumId = tracks.AlbumId
INNER JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
INNER JOIN genres ON genres.GenreId = tracks.GenreId;

-- To create a view based on this query, you use the following statement:
CREATE VIEW v_tracks 
AS 
SELECT
	trackid,
	tracks.name,
	albums.Title AS album,
	media_types.Name AS media,
	genres.Name AS genres
FROM tracks
INNER JOIN albums ON Albums.AlbumId = tracks.AlbumId
INNER JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
INNER JOIN genres ON genres.GenreId = tracks.GenreId;

-- From now on, you can use the following simple query instead of the 
-- complex one above.
SELECT * FROM v_tracks;




-- ## Creating a view with custom column names
-- The following statement creates a view named v_albums that contains album 
-- title and the length of album in minutes:
-- DROP VIEW v_albums;
CREATE VIEW v_albums (
    AlbumTitle,
    Minutes
)
AS
    SELECT albums.title as AlbumTitle,
           SUM(milliseconds) / 60000 as Minutes
    FROM tracks
    INNER JOIN albums USING (AlbumId)
    GROUP BY AlbumTitle;

SELECT * FROM v_albums;


