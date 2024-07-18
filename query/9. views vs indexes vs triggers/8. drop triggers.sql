/*
	# SQLite DROP TRIGGER statement
	- To drop an existing trigger, you use the DROP TRIGGER statement as follows:

			DROP TRIGGER [IF EXISTS] trigger_name;

	- In this syntax:
		+ First, specify the name of the trigger that you want to drop after 
		the DROP TRIGGER keywords.
		+ Second, use the IF EXISTS option to delete the trigger only if it exists.
	
	**Note** that if you drop a table, SQLite will automatically drop all 
	triggers associated with the table.

	
*/

-- For example, to remove the validate_email_before_insert_leads trigger, 
-- you use the following statement:
DROP TRIGGER validate_email_before_insert_leads;
