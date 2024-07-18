CREATE TABLE t(
	c TEXT
);
INSERT INTO t(c)
VALUES('10% increase'),
	('10 times decrease'),
	('100% vs. last year'),
	('20% increase next year');
SELECT * FROM t;



-- 1. attempt to find the row whose value in the c column 
-- contains the 10% literal string:
SELECT c 
FROM t 
WHERE c LIKE '%10%%';


-- 2. to get the correct result, you use the ESCAPE 
-- clause as shown in the following query:
SELECT c 
FROM t 
WHERE c LIKE '%10\%%' ESCAPE '\';