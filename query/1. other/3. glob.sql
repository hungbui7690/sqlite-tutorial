/*
- The GLOB operator is similar to the LIKE operator. The GLOB operator determines whether 
a string matches a specific pattern.
- Unlike the LIKE operator, the GLOB operator is case sensitive and uses the UNIX wildcards. 
In addition, the GLOB patterns do not have escape characters.

	(*) matches any number of characters.
	(?) matches exactly one character.
	[xyz] match any single x, y, or z character.
	[a-z] matches any single lowercase character from a to z. 
	[a-zA-Z0-9] pattern matches any single alphanumeric character, both lowercase, and uppercase.
	[^0-9] pattern matches any single character except a numeric character.
*/


-- 1. The following statement finds tracks whose names start with the string Man. 
-- The pattern Man* matches any string that starts with Man.
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB 'Man*';
	
-- 2. The following statement gets the tracks whose names end with Man. 
-- The pattern *Man matches any string that ends with Man.
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*Man';

-- 3. The following query finds the tracks whose names start with any 
-- single character (?), followed by the string ere and then any 
-- number of character (*).
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '?ere*';

-- 4. To find the tracks whose names contain numbers, you can use 
-- the list wildcard [0-9] as follows:
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*[1-9]*';

-- 5. Or to find the tracks whose name does not contain any number, 
-- you place the character ^ at the beginning of the list:
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*[^1-9]*';


-- 6. The following statement finds the tracks whose names end with a number.
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*[1-9]';