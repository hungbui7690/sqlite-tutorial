/*
	- SQLite does not support built-in date and/or time storage class. 
	Instead, it leverages some built-in date and time functions to use other 
	storage classes such as TEXT, REAL, or INTEGER for storing the date and 
	time values.

	- If you use the TEXT storage class to store date and time value, you need 
	to use the ISO8601 string format as follows:
			YYYY-MM-DD HH:MM:SS.SSS
			2016-01-01 10:20:05.123
*/



-- ## Using the TEXT storage class for storing SQLite date and time
CREATE TABLE datetime_text(
   d1 text, 
   d2 text
);


-- The table contains two column d1 and d2 with TEXT datatype.
-- To insert date and time values into the datetime_text table, 
-- you use the DATETIME function.
-- For example, to get the current UTC date and time value, you pass 
-- the now literal string to the function as follows:
SELECT datetime('now');

-- To get the local time, you pass an additional argument localtime.
SELECT datetime('now','localtime');


-- Second, insert the date and time values into the datetime_text table as follows:
INSERT INTO datetime_text (d1, d2)
VALUES(datetime('now'),datetime('now', 'localtime'));

-- query the datetime_text TABLE
SELECT 
	d1, typeof(d1),
	d2, typeof(d2)
FROM datetime_text;






-- ## Using INTEGER to store SQLite date and time values
-- Besides  TEXT and REAL storage classes, you can use the INTEGER storage class 
-- to store date and time values.
-- We typically use the INTEGER to store UNIX time which is the number of seconds 
-- since 1970-01-01 00:00:00 UTC. See the following example:

CREATE TABLE datetime_int (d1 int);

INSERT INTO datetime_int (d1)
VALUES(strftime('%s','now'));


-- Third, query data from the datetime_int table.
SELECT d1 FROM datetime_int; -- return integer

-- To format the result, you can use the built-in datetime() function as follows:
SELECT datetime(d1,'unixepoch') FROM datetime_int;




