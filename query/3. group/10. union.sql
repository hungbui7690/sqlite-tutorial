/*
	- Sometimes, you need to combine the results of multiple 
	queries into a single result set. To achieve this, you can 
	use the UNION operator.
	- The UNION operator eliminates duplicate rows in the final result 
	set. If you want to retain the duplicate rows, you can use the 
	UNION ALL operator.
	
	- Here are the rules for the queries when using the UNION operator:
		+ The queries (query1 and query2) have the same number of columns.
		+ The corresponding columns must have compatible data types.
		+ The column names of the first query determine the column names of 
		the combined result set.
		+ If you use the GROUP BY and HAVING clauses, they will be applied 
		to each query, not the final result set.
		+ If you use the ORDER BY clause, it will be applied to the combined 
		result set, not the individual result set.
*/

CREATE TABLE  t1 (c1 INT);
CREATE TABLE t2 (c2 INT);

INSERT INTO t1 (c1) VALUES
  (1), (2), (3);
INSERT INTO t2 (c2) VALUES
  (2), (3), (4);


 
-- (1) The following statement combines the result sets of the t1 and t2 
-- tables using the UNION operator:
-- Note that duplication is removed
SELECT c1 FROM t1
UNION
SELECT c2 FROM t2;



-- (2) The following statement combines the result sets of t1 and t2 
-- tables using the  UNION ALL operator:
SELECT c1 FROM t1
UNION ALL
SELECT c2 FROM t2;



-- (3) This statement uses the UNION operator to combine the names of 
-- employees and customers into a single list:
SELECT
  FirstName,
  LastName,
  'Employee' AS Type
FROM employees
UNION
SELECT
  FirstName,
  LastName,
  'Customer'
FROM customers;



-- (4) This example uses the UNION operator to combine the names of the 
-- employees and customers into a single list. In addition, it uses the 
-- ORDER BY clause to sort the name list by first name and last name.
SELECT FirstName, LastName,
  'Employee' AS Type
FROM employees
UNION
SELECT FirstName, LastName,
  'Customer'
FROM customers
ORDER BY FirstName, LastName;

/*
- Use the UNION operator to combine rows from two result sets 
into a single result set.
- Use the UNION ALL operator to retain the duplicate rows in 
the final result set.
*/
