/*
- Sometimes, you don’t know exactly the complete keyword that you want to query. 
- For example, you may know that your most favorite song contains the word, elevator but you 
don’t know exactly the name.
	
- SQLite provides two wildcards for constructing patterns. They are percent sign % and underscore _ :
  - % matches any sequence of zero or more characters. 
	> The s% pattern (%) matches any string that starts with s e.g.,son and so.
	> the %per% pattern matches any string that contains per such as percent and peeper.
  - _ wildcard matches any single character.
	> The h_nt pattern matches hunt, hint, etc. The __pple pattern matches topple, supple, tipple, etc.
*/


-- **NOTE** SQLite LIKE operator is case-insensitive. It means "A" LIKE "a" is true.
-- 		> However, for Unicode characters that are not in the ASCII ranges, the LIKE 
-- 	operator is case sensitive e.g., "Ä" LIKE "ä" is false.
-- > In case you want to make LIKE operator works case-sensitively, you need 
-- 	to use the following PRAGMA:
-- 		  + https://www.sqlite.org/pragma.html#pragma_case_sensitive_like
-- 		  + PRAGMA case_sensitive_like = true;



-- 1. To find the tracks whose names start with the Wild literal string, 
-- you use the percent sign % wildcard at the end of the pattern.
SELECT
	trackid,
	name	
FROM tracks
WHERE name LIKE 'Wild%';


-- 2. To find the tracks whose names end with Wild word, you use 
-- % wildcard at the beginning of the pattern.
SELECT
	trackid,
	name
FROM tracks
WHERE name LIKE '%Wild';


-- 3. To find the tracks whose names contain the Wild literal 
-- string, you use % wildcard at the beginning and end of the pattern:
SELECT
	trackid,
	name	
FROM tracks
WHERE name LIKE '%Wild%';


-- 4. The following statement finds the tracks whose names contain: 
-- zero or more characters (%), followed by Br, followed by a character ( _), 
-- followed by wn, and followed by zero or more characters ( %).
SELECT
	trackid,
	name
FROM tracks
WHERE name LIKE '%Br_wn%';



