/*
	What are INSTEAD OF triggers in SQLite
	- In SQLite, an INSTEAD OF trigger can be only created based on a view, 
	not a table.

	- Views are read-only in SQLite. And if you issue a DML statement such 
	as INSERT, UPDATE, or DELETE against a view, you will receive an error.

	- When a view has an INSTEAD OF trigger, the trigger will fire when you 
	issue a corresponding DML statement. This allows you to inject your own 
	logic in the processing flow.

	- For example, if a view has an INSTEAD OF INSERT trigger, when you issue 
	an INSERT statement, the trigger will fire automatically. Inside the 
	trigger, you can perform insert, update, or delete data in the base tables.

	- In other words, the INSTEAD OF triggers allow views to become modifiable.

	- The following illustrates the syntax of creating an INSTEAD OF trigger 
	in SQLite:
			CREATE TRIGGER [IF NOT EXISTS] schema_ame.trigger_name
				INSTEAD OF [DELETE | INSERT | UPDATE OF column_name]
				ON table_name
			BEGIN
				-- insert code here
			END;
			
	- In this syntax:
		+ First, specify the name of the trigger after the CREATE TRIGGER 
		keywords. Use IF NOT EXISTS if you want to create the trigger if 
		it exists only.
		+ Second, use the INSTEAD OF keywords followed by a triggering 
		event such as INSERT, UPDATE, or DELETE.
		+ Third, specify the name of the view to which the trigger belongs.
		+ Finally, specify the code that executes the logic.		
		
*/

-- ## SQLite INSTEAD OF trigger example
-- First, create a view named AlbumArtists based on data from the Artists 
-- and Albums tables:
CREATE VIEW AlbumArtists(
    AlbumTitle, 
    ArtistName
) AS 
SELECT 
    Title, 
    Name
FROM Albums
INNER JOIN Artists USING (ArtistId);

-- Second, use this query to verify data from the view:
SELECT * FROM AlbumArtists;

-- Third, insert a new row into the AlbumArtists view:
INSERT INTO AlbumArtists(AlbumTitle,ArtistName)
VALUES('Who Do You Trust?','Papa Roach'); -- ERROR

-- Fourth, create an INSTEAD OF trigger that fires when a new row 
-- is inserted into the AlbumArtists table:
CREATE TRIGGER insert_artist_album_trg
    INSTEAD OF INSERT ON AlbumArtists
BEGIN
    -- insert the new artist first
    INSERT INTO Artists(Name)
    VALUES(NEW.ArtistName);
    
    -- use the artist id to insert a new album
    INSERT INTO Albums(Title, ArtistId)
    VALUES(NEW.AlbumTitle, last_insert_rowid());
END;
-- In this trigger:
-- First, insert a new row into the Artists table. SQLite automatically 
-- generates an integer for the ArtistId column.
-- Second, use the last_insert_rowid() to get the generated value from 
-- the ArtistId column and insert a new row into the Albums table.

-- Finally, verify insert from the Artists and Albums tables:
SELECT *   
FROM Artists
ORDER BY ArtistId DESC;
SELECT *
FROM Albums 
ORDER BY AlbumId DESC;











