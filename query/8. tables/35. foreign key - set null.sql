-- ## SQLite foreign key constraint actions
/*
	- What would happen if you delete a row in the supplier_groups 
	table? Should all the corresponding rows in the suppliers table 
	are also deleted? The same questions to the update operation.
	- To specify how foreign key constraint behaves whenever the 
	parent key is deleted or updated, you use the ON DELETE or 
	ON UPDATE action as follows:
		FOREIGN KEY (foreign_key_columns)
		   REFERENCES parent_table(parent_key_columns)
			  ON UPDATE action 
			  ON DELETE action;
			  
	- SQLite supports the following actions:		
		SET NULL
		SET DEFAULT
		RESTRICT
		NO ACTION
		CASCADE
*/

-- ## SET NULL
-- When the parent key changes, delete or update, the corresponding 
-- child keys of all rows in the child table set to NULL.
-- First, drop and create the table suppliers using the SET NULL action 
-- for the group_id foreign key:
DROP TABLE suppliers;
CREATE TABLE suppliers (
    supplier_id   INTEGER PRIMARY KEY,
    supplier_name TEXT    NOT NULL,
    group_id      INTEGER,
    FOREIGN KEY (group_id)
    REFERENCES supplier_groups (group_id) 
       ON UPDATE SET NULL
       ON DELETE SET NULL
);


-- INSERT INTO supplier_groups(group_name) VALUES ('International');
SELECT * FROM supplier_groups;

-- Second, insert some rows into the suppliers table:
INSERT INTO suppliers (supplier_name, group_id)
VALUES('XYZ Corp', 3);
INSERT INTO suppliers (supplier_name, group_id)
VALUES('ABC Corp', 3);

-- Third, delete the supplier group id 3 from the supplier_groups table:
DELETE FROM supplier_groups 
WHERE group_id = 3;


-- Now, the group_id is set to NULL
SELECT * FROM suppliers; 
