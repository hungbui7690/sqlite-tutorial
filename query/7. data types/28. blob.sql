/*
	- BLOB stands for Binary Large Object. In SQLite, you can use the 
	BLOB data type to store binary data such as images, video files, or 
	any raw binary data.
	- Typically, you’ll use an external program to read a file such as 
	an image, and insert the binary into a SQLite database.
*/

CREATE TABLE documents(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    data BLOB NOT NULL -- binary data
);



/*
	- For the demonstration, we’ll use Python to read the binary data from 
	an image file, insert it into an SQLite database, retrieve the BLOB data 
	back, and write the BLOB data as an image.
	
		import sqlite3

		# Connect to an sqlite database
		conn = sqlite3.connect('my.db')
		cursor = conn.cursor()

		# Create the documents table
		cursor.execute('''CREATE TABLE IF NOT EXISTS documents(
							id INTEGER PRIMARY KEY,
							title VARCHAR(255) NOT NULL,
							data BLOB NOT NULL
						);''')

		# Read data from image.jpg and insert
		with open('image.jpg', 'rb') as file:
			image_data = file.read()
			cursor.execute("INSERT INTO documents (title, data) VALUES (?,?)", ('JPG Image',image_data,))

		# Retrieve binary data (blob)
		cursor.execute("SELECT data FROM documents WHERE id = 1")
		data = cursor.fetchone()[0]

		# write the BLOB data into an image file with the name stored_image.jpg:
		with open('stored_image.jpg', 'wb') as file:
			file.write(data)

		# Commit changes and close the database connection
		conn.commit()
		conn.close()
*/ 


