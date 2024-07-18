--	## CASCADE
-- The CASCADE action propagates the changes from the parent table 
-- to the child table when you update or delete the parent key.
DELETE FROM supplier_groups;


-- First, insert the supplier groups into the supplier_groups table:
INSERT INTO supplier_groups (group_name) VALUES
   ('Domestic'),
   ('Global'),
   ('One-Time');

SELECT * FROM supplier_groups;
   
-- Second, drop and create the table suppliers with the CASCADE 
-- action in the foreign key group_id :
DROP TABLE suppliers;
CREATE TABLE suppliers (
    supplier_id   INTEGER PRIMARY KEY,
    supplier_name TEXT    NOT NULL,
    group_id      INTEGER,
    FOREIGN KEY (group_id)
    REFERENCES supplier_groups (group_id) 
       ON UPDATE CASCADE -- here
       ON DELETE CASCADE
);

-- Third, insert some suppliers into the table suppliers:
INSERT INTO suppliers (supplier_name, group_id)
VALUES('XYZ Corp', 1);
INSERT INTO suppliers (supplier_name, group_id)
VALUES('ABC Corp', 2);

-- Fourth, update group_id of the Domestic supplier group to 100:
UPDATE supplier_groups
SET group_id = 100
WHERE group_name = 'Domestic';

/*  - As you can see the value in the group_id column of the 
	XYZ Corp in the table suppliers changed from 1 to 100 when 
	we updated the group_id in the suplier_groups table. This 
	is the result of ON UPDATE CASCADE action. */
SELECT * FROM suppliers;


-- Sixth, delete supplier group id 2 from the supplier_groups table:
DELETE FROM supplier_groups 
WHERE group_id = 2;

-- Seventh, query data from the table suppliers :
SELECT * FROM suppliers;
-- The supplier id 2 whose group_id is 2 was deleted when the 
-- supplier group id 2 was removed from the supplier_groups 
-- table. This is the effect of the ON DELETE CASCADE action.


