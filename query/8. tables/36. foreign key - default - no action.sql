/*
	SET DEFAULT
	- The SET DEFAULT action sets the value of the foreign key to 
	the default value specified in the column definition when you 
	create the table.
	- Because the values in the column group_id defaults to NULL, if 
	you delete a row from the supplier_groups table, the values of 
	the group_id will set to NULL.
	- After assigning the default value, the foreign key constraint 
	kicks in and carries the check.

	
	RESTRICT
	- The RESTRICT action does not allow you to change or delete values 
	in the parent key of the parent table.

*/


-- First, drop and create the suppliers table w ESTRICT action 
-- in the foreign key group_id:
DROP TABLE suppliers;
CREATE TABLE suppliers (
    supplier_id   INTEGER PRIMARY KEY,
    supplier_name TEXT    NOT NULL,
    group_id      INTEGER,
    FOREIGN KEY (group_id)
    REFERENCES supplier_groups (group_id) 
       ON UPDATE RESTRICT
       ON DELETE RESTRICT -- here
);

-- Second, insert a row into the table suppliers with the group_id 1.
INSERT INTO suppliers (supplier_name, group_id)
VALUES('XYZ Corp', 1);

-- Third, delete the supplier group with id 1 from the supplier_groups 
-- table:
DELETE FROM supplier_groups 
WHERE group_id = 1; -- error

-- To fix it, you must first delete all rows from the suppliers table 
-- which has group_id 1:
DELETE FROM suppliers 
WHERE group_id =1;

-- Then, you can delete the supplier group 1 from the supplier_groups table:
DELETE FROM supplier_groups 
WHERE group_id = 1;


-- ## NO ACTION
-- The NO ACTION does not mean by-pass the foreign key constraint. 
-- It has the similar effect as the RESTRICT.




