/*
	- The SQLite CASE expression evaluates a list of conditions and returns 
	an expression based on the result of the evaluation.
	- The CASE expression is similar to the IF-THEN-ELSE statement in other 
	programming languages.
	- You can use the CASE expression in any clause or statement that accepts 
	a valid expression. For example, you can use the CASE expression in clauses 
	such as WHERE, ORDER BY, HAVING, SELECT and statements such as SELECT, UPDATE, 
	and DELETE.
	- SQLite provides two forms of the CASE expression: simple CASE and searched CASE.
*/



-- ## Simple CASE expression
-- (1) Suppose, you have to make a report of the customer groups with the logic 
-- that if a customer locates in the USA, this customer belongs to the domestic 
-- group, otherwise the customer belongs to the foreign group.
-- To make this report, you use the simple CASE expression in the 
-- SELECT statement as follows:
SELECT customerid, firstname, lastname,
       CASE country 
           WHEN 'USA' 
               THEN 'Domestic' 
           ELSE 'Foreign' 
       END CustomerGroup
FROM customers
ORDER BY LastName, FirstName;



-- ## Search CASE Expression
-- (2) The searched CASE expression evaluates a list of expressions to decide 
-- the result. Note that the simple CASE expression only compares for equality, 
-- while the searched CASE expression can use any forms of comparison.
-- 	 Suppose you want to classify the tracks based on its length such 
-- as less a minute, the track is short,. between 1 and 5 minutes, the track is 
-- mediumL,. greater than 5 minutes, the track is long.
-- 	 To achieve this, you use the searched CASE expression as follows:
SELECT trackid, name,
	CASE
		WHEN milliseconds < 60000 THEN 'short'
		WHEN milliseconds > 60000 AND milliseconds < 300000 THEN 'medium'
		ELSE 'long'
		END as category -- alias = category
FROM
	tracks;




