/*
	## Getting the structure of a table via the SQLite command-line 
	shell program

		- Here is the output:
			CREATE TABLE IF NOT EXISTS "albums"
			(
				[AlbumId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
				[Title] NVARCHAR(160)  NOT NULL,
				[ArtistId] INTEGER  NOT NULL,
				FOREIGN KEY ([ArtistId]) REFERENCES "artists" ([ArtistId])
							ON DELETE NO ACTION ON UPDATE NO ACTION
			);
			CREATE INDEX [IFK_AlbumArtistId] ON "albums" ([ArtistId]);	
	

		- To find out the structure of a table via the SQLite 
		command-line shell program, you follow these steps:
			+ First, connect to a database via the SQLite command-line 
			shell program:
				> sqlite3 c:\sqlite\db\chinook.db

			+ Then, issue the following command:
				> .schema table_name

			+For example, the following command shows the statement 
			that created the albums table:
				> .schema albums

			
		*** Notice that there is no semicolon (;) after the table name. 
		If you add a semicolon (;), the .schema will consider the 
		albums; as the table name and returns nothing because the 
		table albums; does not exist.
		
		
		- Another way to show the structure of a table is to use 
		the PRAGMA command. To do it, you use the following command 
		to format the output:
				> .header on
				> .mode column
			
		- And use the PRAGMA command as follows:
				> pragma table_info('albums');
				
	
	
	
	## Getting the structure of a table using the SQL statement
	- You can find the structure of a table by querying it from the 
	sqlite_schema table as follows:
			SELECT sql 
			FROM sqlite_schema 
			WHERE name = 'albums';
	
	- Here is the output:
			sql
			------------
			CREATE TABLE "albums"
			(
				[AlbumId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
				[Title] NVARCHAR(160)  NOT NULL,
				[ArtistId] INTEGER  NOT NULL,
				FOREIGN KEY ([ArtistId]) REFERENCES "artists" ([ArtistId])
							ON DELETE NO ACTION ON UPDATE NO ACTION
			)        
*/


pragma table_info('albums');

SELECT sql 
FROM sqlite_schema 
WHERE name = 'albums';