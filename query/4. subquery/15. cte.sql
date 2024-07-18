/*
	In SQLite, common table expressions (CTE) are temporary result sets defined 
within the scope of a query. CTEs allow you to make your query more readable.
	Additionally, CTEs enable modular SQL queries by breaking them into smaller, 
logical units.
	In practice, you can use CTEs to replace the subqueries to make them more readable.
	Use common table expressions (CTE) to create a temporary result set defined within the 
scope of a query.
	
	Syntax: 
	- First, specify a name for the CTE in the WITH clause.
	- Second, provide a query that defines the CTE inside the parentheses followed by 
the AS keyword. The result set followed by this query forms the temporary result set 
you can reference in the main query.
	- Third, write the main query that references the CTE.
*/


-- (1) The following example uses a CTE to retrieve the top 5 tracks from the tracks table:
--   First, define a CTE named top_tracks that retrieves the top 5 
-- tracks from the tracks table.
--   Second, select track_id and name from the CTE.
WITH top_tracks AS (
    SELECT trackid, name
    FROM tracks
    ORDER BY trackid
    LIMIT 5
) SELECT * FROM top_tracks;



-- (2) The following example uses a CTE to find the top 5 customers 
-- by total sales from the invoices and invoice_items tables:
WITH customer_sales AS (
    SELECT c.customerid,
           c.firstname || ' ' || c.lastname AS customer_name,
           ROUND(SUM(ii.unitprice * ii.quantity),2) AS total_sales
    FROM customers c
    INNER JOIN invoices i ON c.customerid = i.customerid
    INNER JOIN invoice_items ii ON i.invoiceid = ii.invoiceid
    GROUP BY c.customerid
) 
SELECT customer_name, total_sales 
FROM customer_sales
ORDER BY total_sales DESC, customer_name
LIMIT 5;

