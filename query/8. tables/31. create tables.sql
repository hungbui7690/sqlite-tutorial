/*
	Syntax: 

		CREATE TABLE [IF NOT EXISTS] [schema_name].table_name (
			column_1 data_type PRIMARY KEY,
			column_2 data_type NOT NULL,
			column_3 data_type DEFAULT 0,
			table_constraints
		) [WITHOUT ROWID];
		
	- IF NOT EXISTS
	- column constraints: PRIMARY KEY, UNIQUE, NOT NULL, 
	and CHECK column constraints.
	-  WITHOUT ROWID (optional): By default, a row in a table has an implicit column, 
	which is referred to as the rowid, oid or _rowid_ column. The rowid column stores 
	a 64-bit signed integer key that uniquely identifies the row inside the table. 
	If you don’t want SQLite creates the rowid column, you specify the WITHOUT ROWID 
	option. A table that contains the rowid column is known as a rowid table. 
	Note that the WITHOUT ROWID option is only available in SQLite 3.8.2 or later.
	
	** NOTE ** 
			- primary key of a table is a "column" or a "group of columns" that 
	uniquely identify each row in the table.
			- To add the table primary key constraint, you use this syntax:
				> PRIMARY KEY (contact_id, group_id)
*/


-- Suppose you have to manage contacts using SQLite.
-- Each contact has the following information:
-- 	 First name
-- 	 Last name
-- 	 Email
-- 	 Phone
-- The requirement is that the email and phone must be unique. In addition, each 
-- contact belongs to one or many groups, and each group can have zero or many contacts.
-- Based on these requirements, we came up with three tables:
-- 	 The contacts table that stores contact information.
-- 	 The groups table that stores group information.
-- 	 The contact_groups table that stores the relationship between contacts and groups.
-- 	 The following database diagram illustrates tables: contacts groups, and contact_groups.
CREATE TABLE contacts (
	contact_id INTEGER PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	phone TEXT NOT NULL UNIQUE
);

CREATE TABLE groups (
   group_id INTEGER PRIMARY KEY,
   name TEXT NOT NULL
);

CREATE TABLE contact_groups(
   contact_id INTEGER,
   group_id INTEGER,
   PRIMARY KEY (contact_id, group_id), -- compound primary key
   FOREIGN KEY (contact_id) -- foreign key 1
      REFERENCES contacts (contact_id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION,
   FOREIGN KEY (group_id)  -- foreign key 2
      REFERENCES groups (group_id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
);








