## Like
Sometimes, you don’t know exactly the complete keyword that you want to query. 

For example, you may know that your most favorite song contains the word, elevator but you don’t know exactly the name.
	
SQLite provides two wildcards for constructing patterns. They are percent sign % and underscore _ :
- % matches any sequence of zero or more characters. 
	- The s% pattern (%) matches any string that starts with s e.g.,son and so.
- the %per% pattern matches any string that contains per such as percent and peeper.
- _ wildcard matches any single character.
	- The h_nt pattern matches hunt, hint, etc. The __pple pattern matches topple, supple, tipple, etc.



**NOTE** 
SQLite LIKE operator is case-insensitive. It means "A" LIKE "a" is true.
- However, for Unicode characters that are not in the ASCII ranges, the LIKE operator is case sensitive e.g., "Ä" LIKE "ä" is false.
- In case you want to make LIKE operator works case-sensitively, you need to use the following PRAGMA: https://www.sqlite.org/pragma.html#pragma_case_sensitive_like
```shell
PRAGMA case_sensitive_like = true;
```

![tracks](https://www.sqlitetutorial.net/wp-content/uploads/2018/11/tracks.png)


To find the tracks whose names start with the Wild literal string, you use the percent sign % wildcard at the end of the pattern.
```sql
SELECT
	trackid,
	name	
FROM tracks
WHERE name LIKE 'Wild%';

TrackId	Name
1245	Wildest Dreams
1973	Wild Side
2627	Wild Hearted Son
2633	Wild Flower
2944	Wild Honey
```


To find the tracks whose names end with Wild word, you use % wildcard at the beginning of the pattern.
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name LIKE '%Wild';

TrackId	Name
4	Restless and Wild
32	Deuces Are Wild
775	Call Of The Wild
2697	I Go Wild
```




To find the tracks whose names contain the Wild literal string, you use % wildcard at the beginning and end of the pattern:
```sql
SELECT
	trackid,
	name	
FROM tracks
WHERE name LIKE '%Wild%';

TrackId	Name
4	Restless and Wild
32	Deuces Are Wild
775	Call Of The Wild
1245	Wildest Dreams
1869	Where The Wild Things Are
1973	Wild Side
2312	Near Wild Heaven
2627	Wild Hearted Son
2633	Wild Flower
2697	I Go Wild
2930	Who's Gonna Ride Your Wild Horses
2944	Wild Honey
```


Finds the tracks
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name LIKE '%Br_wn%';

TrackId	Name
1053	Bad, Bad Leroy Brown
1150	Mr. Brownstone
```


#### Escape
If the pattern that you want to match contains % or _, you must use an escape character in an optional ESCAPE clause as follows:

```sql
column_1 LIKE pattern ESCAPE expression;
```


```sql
CREATE TABLE t(
	c TEXT
);

INSERT INTO t(c)
VALUES('10% increase'),
	('10 times decrease'),
	('100% vs. last year'),
	('20% increase next year');

SELECT * FROM t;

c
10% increase
10 times decrease
100% vs. last year
20% increase next year
10% increase
10 times decrease
100% vs. last year
20% increase next year
```


Attempt to find the row whose value in the c column contains the 10% literal string:
```sql
SELECT c 
FROM t 
WHERE c LIKE '%10%%';

c
10% increase
10 times decrease
100% vs. last year
10% increase
10 times decrease
100% vs. last year
```


To get the correct result, you use the ESCAPE clause as shown in the following query:
```sql
SELECT c 
FROM t 
WHERE c LIKE '%10\%%' ESCAPE '\';

c
10% increase
10% increase
```


## Glob

The GLOB operator is similar to the LIKE operator. The GLOB operator determines whether 
a string matches a specific pattern.

Unlike the LIKE operator, the GLOB operator is case sensitive and uses the UNIX wildcards. 
In addition, the GLOB patterns do not have escape characters.

```
(*) matches any number of characters.
(?) matches exactly one character.
[xyz] match any single x, y, or z character.
[a-z] matches any single lowercase character from a to z. 
[a-zA-Z0-9] pattern matches any single alphanumeric character, both lowercase, and uppercase.
[^0-9] pattern matches any single character except a numeric character.
```


The following statement finds tracks whose names start with the string Man. The pattern Man* matches any string that starts with Man.
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB 'Man*';

TrackId	Name
52	Man In The Box
106	Man Or Animal
257	Manguetown
358	Man With The Woman Head
562	Mangueira
584	Manuel
1397	Man On The Edge
1459	Manifest Destiny
1480	Manic Depression
2046	Manguetown
2859	Man of Science, Man of Faith (Premiere)
```
	
The following statement gets the tracks whose names end with Man. The pattern *Man matches any string that ends with Man.
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*Man';

TrackId	Name
31	Blind Man
359	Muffin Man
431	The Invisible Man
....
2855	Company Man
2880	Confidence Man
2986	Wake Up Dead Man
3022	Drowning Man
3090	Ice Cream Man
3223	How to Stop an Exploding Man
3379	She'll Never Be Your Man
3427	Fanfare for the Common Man
```

The following query finds the tracks whose names start with any single character (?), followed by the string ere and then any number of character (*).
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '?ere*';


TrackId	Name
324	Pererê
1132	Serenity
1452	Were Do We Go From Here
1740	Sereia
...
3042	Here I Am (Come And Take Me)
3133	Here I Go Again
```

To find the tracks whose names contain numbers, you can use the list wildcard [0-9] as follows:
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*[1-9]*';

TrackId	Name
109	#1 Zero
122	20 Flight Rock
132	13 Years Of Grief
343	Communication Breakdown(2)
347	Communication Breakdown(3)
3489	Symphony No. 2: III. Allegro vivace
...
```

Or to find the tracks whose name does __not__ contain any number, you place the character __^__ at the beginning of the list:
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*[^1-9]*';

TrackId	Name
1	For Those About To Rock (We Salute You)
2	Balls to the Wall
3	Fast As a Shark
4	Restless and Wild
5	Princess of the Dawn
6	Put The Finger On You
...
3503	Koyaanisqatsi
```


The following statement finds the tracks whose names end with a number.
```sql
SELECT
	trackid,
	name
FROM tracks
WHERE name GLOB '*[1-9]';

TrackId	Name
366	Camisa Verde 2001
367	Leandro De Itaquera 2001
368	Tucuruvi 2001
369	Aguia De Ouro 2001
...
```




## Join
In the tracks table, the AlbumId column is a foreign key. And in the albums table, the AlbumId is the primary key. To query data from both tracks and albums tables, you use the following statement:
```sql
SELECT
	trackid,
	name,
	title
FROM tracks
INNER JOIN albums 
	ON albums.albumid = tracks.albumid;
```


![link](https://i.ibb.co/ZS0MzCW/2024-06-27-211002.png) 
*Caption*

For each row in the tracks table, SQLite uses the value in the albumid column of the tracks table to compare with the value in the albumid of the albums table. 

If SQLite finds a match, it combines data of rows in both tables in the result set.


You can include the AlbumId columns from both tables in the final result set to see the effect.
```sql
SELECT
    trackid,
    name,
    tracks.albumid AS album_id_tracks,
    albums.albumid AS album_id_albums,
    title
FROM tracks
INNER JOIN albums 
	ON albums.albumid = tracks.albumid;


```

![link](https://i.ibb.co/0mb0qDP/2024-06-27-211050.png) 


One track belongs to one album and one album have many tracks. The tracks table associated with the albums table via albumid column. 

One album belongs to one artist and one artist has one or many albums. The albums table links to the artists table via artistid column. 

To query data from these tables, you need to use two inner join clauses in the SELECT statement as follows:
```sql
SELECT
    trackid,
    tracks.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid;
```


You can use a WHERE clause to get the tracks and albums of the artist with id 10 as the following statement:
```sql
SELECT
	trackid,
	tracks.name AS Track,
	albums.title AS Album,
	artists.name AS Artist
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid
WHERE artists.artistid = 10;
```

![alt text](https://i.ibb.co/0jMZvzq/2024-06-27-211148.png)



## Left Join

One album belongs to one artist. However, one artist may have zero or more albums. 

To find artists who do not have any albums by using the LEFT JOIN clause, we select artists and their corresponding albums. If an artist does not have any albums, the value of the AlbumId column is NULL.
```sql
SELECT
   artists.ArtistId, 
   AlbumId
FROM artists
LEFT JOIN albums ON albums.ArtistId = artists.ArtistId
ORDER BY AlbumId;
```

![alt text](https://i.ibb.co/DWFZDkt/2024-06-27-211243.png)


Find the artists who don't have album
```sql
SELECT
   artists.ArtistId, 
   AlbumId
FROM artists 
LEFT JOIN albums ON albums.ArtistId = artists.ArtistId
WHERE AlbumId IS NULL;
```


## Cross Join
If you use a LEFT JOIN, INNER JOIN, or CROSS JOIN without the ON or USING clause, SQLite produces a cartesian product of the involved tables. 

The number of rows in the cartesian product is the product of the number of rows in each table. 

**NOTE**: no join condition when using CROSS JOIN

```sql
CREATE TABLE ranks (RANK TEXT NOT NULL);
CREATE TABLE suits (suit TEXT NOT NULL);
INSERT INTO ranks (RANK) VALUES
  ('2'),('3'),('4'),('5'),('6'),('7'),
  ('8'),('9'),('10'),('J'),('Q'),('K'),('A');
INSERT INTO suits (suit) VALUES
  ('Clubs'),('Diamonds'),('Hearts'),('Spades');
```
  
  
The following statement uses the CROSS JOIN clause to return a complete deck of cards data:
```sql
SELECT
  RANK,
  suit
FROM
  ranks
  CROSS JOIN suits
ORDER BY
  suit;
```


## Self Join
Because you cannot refer to the same table more than one in a query, you need to use a table alias to assign the table a different name when you use self-join.

The employees table stores not only employee data but also organizational data. The ReportsTo column specifies the reporting relationship between employees. 

If an employee reports to a manager, the value of the ReportsTo column of the row is equal to the value of the EmployeeId column of the manager’s row. 

In case an employee does not report to anyone, the ReportsTo column is NULL.

```sql
SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
FROM employees e
INNER JOIN employees m ON m.employeeid = e.reportsto
ORDER BY manager;
```

![alt text](https://i.ibb.co/PrcW3fc/2024-06-27-211354.png)

Because we used the INNER JOIN clause to join the employees table to itself, 
the result set does not have the row whose manager column contains a NULL value.


In case you want to query the CEO who does not report to anyone, you need to change the INNER JOIN clause to LEFT JOIN clause in the query above.
```sql
SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
FROM employees e
LEFT JOIN employees m ON m.employeeid = e.reportsto
ORDER BY manager;
```


You can use the self-join technique to find the employees located in the same city as the following query:
```sql
SELECT DISTINCT
	e1.city,
	e1.firstName || ' ' || e1.lastname AS fullname
FROM employees e1
INNER JOIN employees e2 ON e2.city = e1.city 
   AND (e1.firstname <> e2.firstname AND e1.lastname <> e2.lastname)
ORDER BY e1.city;
```

![alt text](https://i.ibb.co/LJwgjMh/2024-06-27-211440.png)

- e1.city = e2.city to make sure that both employees located in the same city
- firstname <> e2.firstname AND e1.lastname <> e2.lastname to ensure that e1 and e2 are not the same employee with the assumption that there aren’t employees who have the same first name and last name.





## Group By

The following statement returns the album id and the number of tracks per album. It uses the GROUP BY clause to groups tracks by album and applies the COUNT() function to each group.

```sql
SELECT
	albumid,
	COUNT(trackid)
FROM tracks
GROUP BY albumid
ORDER BY COUNT(trackid) DESC;
```

You can query data from multiple tables using the INNER JOIN clause, then use the GROUP BY clause to group rows into a set of summary rows. 

For example, the following statement joins the tracks table with the albums table to get the album’s titles and uses the GROUP BY clause with the COUNT function to get the number of tracks per album.

```sql
SELECT
	tracks.albumid,
	title,
	COUNT(trackid)
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY tracks.albumid;
```


To filter groups, you use the GROUP BY with HAVING clause. 

For example, to get the albums that have more than 15 tracks, you use the following statement:

```sql
SELECT
	tracks.albumid,
	title,
	COUNT(trackid)
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY tracks.albumid
HAVING COUNT(trackid) > 15;
```


You can use the SUM function to calculate total per group. 

For example, to get total length and bytes for each album, you use the SUM function to calculate total milliseconds and bytes.
```sql
SELECT
	albumid,
	SUM(milliseconds) length,
	SUM(bytes) size
FROM tracks
GROUP BY albumid;
```


The following statement returns the album id, album title, maximum length, minimum length, and the average length of tracks in the tracks table.

```sql
SELECT
	tracks.albumid,
	title,
	min(milliseconds),
	max(milliseconds),
	round(avg(milliseconds),2)
FROM tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY tracks.albumid;
```


SQLite allows you to group rows by multiple columns. For example, to group tracks by media type and genre, you use the following statement:

```sql
SELECT
   MediaTypeId, 
   GenreId, 
   COUNT(TrackId)
FROM tracks
GROUP BY 
   MediaTypeId, 
   GenreId;
```
   
   
The following statement returns the number of invoice by years.

```sql
SELECT
   STRFTIME('%Y', InvoiceDate) InvoiceYear, 
   COUNT(InvoiceId) InvoiceCount
FROM invoices
GROUP BY STRFTIME('%Y', InvoiceDate)
ORDER BY InvoiceYear;
```




## Having
You often use the HAVING clause with the GROUP BY clause. 

The GROUP BY clause groups a set of rows into a set of summary rows or groups. 

Then the HAVING clause filters groups based on a specified condition.

If you use the HAVING clause, you must include the GROUP BY clause
	
**NOTE** 
- Note that the HAVING clause is applied after GROUP BY clause, whereas the WHERE clause is applied before the GROUP BY clause.


To find the number of tracks for each album, you use GROUP BY clause to find the numbers of tracks for the album with id 1, we add a HAVING clause to the following statement:

```sql
SELECT
	AlbumId,
	COUNT(TrackId)
FROM tracks
GROUP BY AlbumId
HAVING AlbumId = 1;	
```
	
	
To find albums that have the number of tracks between 18 and 20, you use the aggregate function in the HAVING clause as shown in the following statement:

```sql
SELECT
   albumid,
   COUNT(trackid)
FROM tracks
GROUP BY albumid
HAVING COUNT(albumid) BETWEEN 18 AND 20
ORDER BY albumid;
```	
	
	
The following statement queries data from tracks and albums tables using inner join to find albums that have the total length greater than 60,000,000 milliseconds.	

```sql
SELECT
	tracks.AlbumId,
	title,
	SUM(Milliseconds) AS length
FROM tracks 
INNER JOIN albums ON albums.AlbumId = tracks.AlbumId
GROUP BY tracks.AlbumId 
HAVING length > 60000000;
```	


## Union
Sometimes, you need to combine the results of multiple queries into a single result set. To achieve this, you can use the UNION operator.

The UNION operator eliminates duplicate rows in the final result set. If you want to retain the duplicate rows, you can use the UNION ALL operator.
	
Here are the rules for the queries when using the UNION operator:
- The queries (query1 and query2) have the same number of columns.
- The corresponding columns must have compatible data types.
- The column names of the first query determine the column names of the combined result set.
- If you use the GROUP BY and HAVING clauses, they will be applied to each query, not the final result set.
- If you use the ORDER BY clause, it will be applied to the combined result set, not the individual result set.

```sql
CREATE TABLE  t1 (c1 INT);
CREATE TABLE t2 (c2 INT);

INSERT INTO t1 (c1) VALUES
  (1), (2), (3);
INSERT INTO t2 (c2) VALUES
  (2), (3), (4);
```

 
The following statement combines the result sets of the t1 and t2 tables using the UNION operator: Note that duplication is removed.

```sql
SELECT c1 FROM t1
UNION
SELECT c2 FROM t2;
```


The following statement combines the result sets of t1 and t2 tables using the  UNION ALL operator:

```sql
SELECT c1 FROM t1
UNION ALL
SELECT c2 FROM t2;
```

This statement uses the UNION operator to combine the names of employees and customers into a single list:

```sql
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
```


This example uses the UNION operator to combine the names of the employees and customers into a single list. 

In addition, it uses the ORDER BY clause to sort the name list by first name and last name.

```sql
SELECT FirstName, LastName,
  'Employee' AS Type
FROM employees
UNION
SELECT FirstName, LastName,
  'Customer'
FROM customers
ORDER BY FirstName, LastName;
```

Use the UNION operator to combine rows from two result sets into a single result set.

Use the UNION ALL operator to retain the duplicate rows in the final result set.




## Except
SQLite EXCEPT operator compares the result sets of two queries and returns distinct rows from the first query that are not output by the second query.

This query must conform to the following rules:
+ First, the number of columns in the select lists of both queries must be the same.
+ Second, the order of the columns and their types must be comparable.


The following statement illustrates how to use the EXCEPT operator to compare result sets of two queries: <1> is in t1, but not t2
```sql
SELECT c1 FROM t1
EXCEPT 
SELECT c2 FROM t2;
```

```sql
CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT,
    author TEXT,
    genre TEXT,
    price REAL
);

CREATE TABLE customerz (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT
);

CREATE TABLE purchases (
    purchase_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    book_id INTEGER,
    purchase_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customerz(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO books (title, author, genre, price) VALUES
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 12.99),
('1984', 'George Orwell', 'Science Fiction', 10.99),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 9.99),
('Pride and Prejudice', 'Jane Austen', 'Romance', 8.99),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 11.99);

INSERT INTO customerz (name, email) VALUES
('Alice', 'alice@gmail.com'),
('Bob', 'bob@yahoo.com'),
('Charlie', 'charlie@outlook.com');

INSERT INTO purchases (customer_id, book_id, purchase_date) VALUES
(1, 1, '2024-04-25'), Alice purchased 'To Kill a Mockingbird'
(1, 3, '2024-04-27'), Alice purchased 'The Great Gatsby'
(2, 2, '2024-04-26'); Bob purchased '1984'
```


Use the EXCEPT operator to find books that have not had any sales: NO NEED TO JOIN on both queries

```sql
SELECT title, author, genre, price
FROM books
EXCEPT
SELECT title, author, genre, price
FROM books
JOIN purchases ON books.book_id = purchases.book_id;
```

The first query selects all books from the books table.

The second query retrieves books that have orders by joining the books table with the orders table.

The EXCEPT operator returns a list of distinct books that have not been ordered by any customer.





## Intercept
SQLite INTERSECT operator allows you to combine the result sets of two queries and returns distinct rows that appear in both result sets of the queries.

The basic rules for combining the result sets of two queries are as follows:
+ First, the number and the order of the columns in all queries must be the same.
+ Second, the data types must be comparable.



Intersect = Intersect + Distince: remove duplications

```sql
SELECT c1 FROM t1
INTERSECT
SELECT c2 FROM t2;
```

The following statement uses the INTERSECT operator to find customers who have invoices:

```sql
SELECT CustomerId, FirstName, LastName
FROM customers
INTERSECT
SELECT CustomerId, FirstName, LastName
FROM invoices
INNER JOIN customers USING (CustomerId)
ORDER BY CustomerId;
```


## Subquery
A subquery is a SELECT statement nested in another statement. 

You must use a pair of parentheses to enclose a subquery. 
	
**Note** that you can nest a subquery inside another subquery with a certain depth.
- Typically, a subquery returns a single row as an atomic value, though it may return multiple rows for comparing values with the "IN" operator.
- You can use a subquery in the SELECT, FROM, WHERE, and JOIN clauses.


You can use a simple subquery as a search condition. For example, the following statement returns all the tracks in the album with the title "Let There Be Rock"

```sql
SELECT trackid,
       name,
       albumid
FROM tracks
WHERE albumid = (
   SELECT albumid
   FROM albums
   WHERE title = 'Let There Be Rock'
);
```
The subquery returns the id of the album with the title 'Let There Be Rock'. The query uses the equal operator (=) to compare albumid returned by the subquery with the  albumid in the tracks table.

If the subquery returns multiple values, you can use the IN operator to check for the existence of a single value against a set of value.



The following query returns the customers whose sales representatives are in Canada.

```sql
SELECT customerid,
       firstname,
       lastname
FROM customers
WHERE supportrepid IN (
		SELECT employeeid
		FROM employees
		WHERE country = 'Canada' return multi values
	);
```	
	
	
__NOT VALID__: Sometimes you want to apply aggregate functions to a column multiple times. For example, first, you want to sum the size of an album and then calculate the average size of all albums. You may come up with the following query.

```sql
SELECT AVG(SUM(bytes) 
FROM tracks
GROUP BY albumid;
```

To fix it, you can use a subquery in the FROM clause as follows:

```sql
SELECT AVG(album.size)
FROM (
	SELECT SUM(bytes) SIZE
	FROM tracks
	GROUP BY albumid
) AS album;
```

All the subqueries you have seen so far can be executed independently. In other words, it does not depend on the outer query.

The correlated subquery is a subquery that uses the values from the outer query. Unlike an ordinal subquery, a correlated cannot be executed independently.

The correlated subquery is not efficient because it is evaluated for each row processed by the outer query.


The following query uses a correlated subquery to return the albums whose size is less than 10MB.

```sql
SELECT albumid,
       title
FROM albums
WHERE 10000000 > (
	SELECT sum(bytes) 
	FROM tracks
	WHERE tracks.AlbumId = albums.AlbumId)
ORDER BY title;
```
For each row processed in the outer query, the correlated subquery calculates the size of the albums from the tracks that belong the current album using the SUM function.

The predicate in the WHERE clause filters the albums that have the size greater than or equal 10MB (10000000 bytes).




The following query uses a correlated subquery in the SELECT clause to return the number of tracks in an album.

```sql
SELECT albumid,
       title,
       (
           SELECT count(trackid) 
           FROM tracks
           WHERE tracks.AlbumId = albums.AlbumId
       ) as tracks_count
FROM albums
ORDER BY tracks_count DESC;
```



## Exists
The EXISTS operator is a logical operator that checks whether a subquery returns any row.

If the subquery returns one or more row, the EXISTS operator return true. 

Otherwise, the EXISTS operator returns false or NULL.

The following statement finds customers who have invoices:

```sql
SELECT
    CustomerId,
    FirstName,
    LastName,
    Company
FROM Customers c
WHERE EXISTS (
	SELECT 1 1 means true 
	FROM Invoices
	WHERE CustomerId = c.CustomerId
    )
ORDER BY 
    FirstName,
    LastName; 
```	
	
	
Notice that you can use the IN operator instead of EXISTS operator in this case to achieve the same result:

```sql
SELECT
   CustomerId, 
   FirstName, 
   LastName, 
   Company
FROM Customers c
WHERE CustomerId IN (
  SELECT CustomerId
  FROM Invoices
   )
ORDER BY
   FirstName, 
   LastName;
```

Once the subquery returns the first row, the EXISTS operator stops searching because it can determine the result. On the other hand, the IN operator must scan all rows returned by the subquery to determine the result.

Generally speaking, the EXISTS operator is faster than IN operator if the result set returned by the subquery is large. By contrast, the IN operator is faster than the EXISTS operator if the result set returned by the subquery is small.

This query find all artists who do not have any album in the Albums table:

```sql
SELECT *
FROM Artists a
WHERE NOT EXISTS(
  SELECT 1
  FROM Albums
  WHERE ArtistId = a.ArtistId
   )
ORDER BY Name;
```



## CTE
In SQLite, common table expressions (CTE) are temporary result sets defined within the scope of a query. CTEs allow you to make your query more readable.

Additionally, CTEs enable modular SQL queries by breaking them into smaller, logical units.

In practice, you can use CTEs to replace the subqueries to make them more readable.

Use common table expressions (CTE) to create a temporary result set defined within the scope of a query.
	
__Syntax__ 
- First, specify a name for the CTE in the WITH clause.
- Second, provide a query that defines the CTE inside the parentheses followed by the AS keyword. The result set followed by this query forms the temporary result set you can reference in the main query.
- Third, write the main query that references the CTE.


The following example uses a CTE to retrieve the top 5 tracks from the tracks table: 
-	First, define a CTE named top_tracks that retrieves the top 5 tracks from the tracks table.
- Second, select track_id and name from the CTE.

```sql
WITH top_tracks AS (
    SELECT trackid, name
    FROM tracks
    ORDER BY trackid
    LIMIT 5
) SELECT * FROM top_tracks;
```


The following example uses a CTE to find the top 5 customers by total sales from the invoices and invoice_items tables:

```sql
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
```



## Case
The SQLite CASE expression evaluates a list of conditions and returns an expression based on the result of the evaluation.

The CASE expression is similar to the IF-THEN-ELSE statement in other programming languages.

You can use the CASE expression in any clause or statement that accepts a valid expression. For example, you can use the CASE expression in clauses such as WHERE, ORDER BY, HAVING, SELECT and statements such as SELECT, UPDATE, 
and DELETE.

SQLite provides two forms of the CASE expression: simple CASE and searched CASE.




#### Simple CASE expression
Suppose, you have to make a report of the customer groups with the logic that if a customer locates in the USA, this customer belongs to the domestic group, otherwise the customer belongs to the foreign group. 

To make this report, you use the simple CASE expression in the SELECT statement as follows:

```sql
SELECT customerid, firstname, lastname,
       CASE country 
           WHEN 'USA' 
               THEN 'Domestic' 
           ELSE 'Foreign' 
       END CustomerGroup
FROM customers
ORDER BY LastName, FirstName;
```


#### Search CASE Expression
The searched CASE expression evaluates a list of expressions to decide  the result. Note that the simple CASE expression only compares for equality, while the searched CASE expression can use any forms of comparison. 

Suppose you want to classify the tracks based on its length such as less a minute, the track is short,. between 1 and 5 minutes, the track is  medium,. greater than 5 minutes, the track is long. 

To achieve this, you use the searched CASE expression as follows:

```sql
SELECT trackid, name,
	CASE
		WHEN milliseconds < 60000 THEN 'short'
		WHEN milliseconds > 60000 AND milliseconds < 300000 THEN 'medium'
		ELSE 'long'
		END as category alias = category
FROM
	tracks;
```


## Insert

### Inserting a single row into a table

The following statement insert a new row into the artists table: Because the ArtistId column is an auto-increment column, you can ignore it in the statement. 

SQLite automatically generate a sequential integer number to insert into the ArtistId column.

```sql
INSERT INTO artists (name)
VALUES('Bud Powell');
```

You can verify the insert operation by using the following SELECT statement:

```sql
SELECT ArtistId, Name
FROM Artists
ORDER BY ArtistId DESC
LIMIT 1;
```


### Inserting multiple rows into a table

The following example inserts three rows into the artists table:

```sql
INSERT INTO artists (name) VALUES
	("Buddy Rich"),
	("Candido"),
	("Charlie Byrd");
```
	
Verify
```sql
SELECT ArtistId, Name
FROM artists 
ORDER BY ArtistId DESC
LIMIT 3; 
```


### Inserting default values
When you create a new table using the CREATE TABLE statement, you can specify default values for columns, or a NULL if a default value is not specified.

The third form of the INSERT statement is INSERT DEFAULT VALUES, which inserts a new row into a table using the default values specified in the column definition or NULL if the default value is not available and the column does not have a NOT NULL constraint.

For example, the following statement inserts a new row into the artists table using INSERT DEFAULT VALUES:

```sql
INSERT INTO artists DEFAULT VALUES;
```

Verify: The default value of the ArtistId column is the next sequential integer . However, the name column does not have any default value, therefore, the INSERT DEFAULT VALUES statement inserts NULL into it.

```sql
SELECT ArtistId, Name
FROM artists
ORDER BY ArtistId DESC;
```

#### Inserting new rows with data provided by a SELECT statement 
Suppose you want to backup the artists table, you can follow these steps: First, create a new table named artists_backup as follows:

```sql
CREATE TABLE artists_backup(
   ArtistId INTEGER PRIMARY KEY AUTOINCREMENT,
   Name NVARCHAR
);
```

To insert data into the artists_backup table with the data from the artists table, you use the INSERT INTO SELECT statement as follows:

```sql
INSERT INTO artists_backup 
SELECT ArtistId, Name
FROM artists;
```

If you query data from the artists_backup table, you will see all  data in the artists table.

```sql
SELECT * FROM artists_backup;
```


## Update

#### Inserting a single row into a table
The following statement insert a new row into the artists table: Because the ArtistId column is an auto-increment column, you can ignore it in the statement. SQLite automatically geneate a sequential integer number to insert into the ArtistId column.

```sql
INSERT INTO artists (name)
VALUES('Bud Powell');
```

You can verify the insert operation by using the following SELECT statement:

```sql
SELECT ArtistId, Name
FROM Artists
ORDER BY ArtistId DESC
LIMIT 1;
```


#### Inserting multiple rows into a table

The following example inserts three rows into the artists table:

```sql
INSERT INTO artists (name) VALUES
	("Buddy Rich"),
	("Candido"),
	("Charlie Byrd");
```

Verify

```sql
SELECT ArtistId, Name
FROM artists 
ORDER BY ArtistId DESC
LIMIT 3; 
```


## Inserting default values
When you create a new table using the CREATE TABLE statement, you can specify default values for columns, or a NULL if a default value is not specified.

The third form of the INSERT statement is INSERT DEFAULT VALUES, which inserts a new row into a table using the default values specified in the column definition or NULL if the default value is not available and the column does not have a NOT NULL constraint.

For example, the following statement inserts a new row into the artists table using INSERT DEFAULT VALUES:

```sql
INSERT INTO artists DEFAULT VALUES;
```

Verify: The default value of the ArtistId column is the next sequential integer . However, the name column does not have any default value, therefore, the INSERT DEFAULT VALUES statement inserts NULL into it.

```sql
SELECT ArtistId, Name
FROM artists
ORDER BY ArtistId DESC;
```

#### Inserting new rows with data provided by a SELECT statement

Suppose you want to backup the artists table, you can follow these steps: First, create a new 
table named artists_backup as follows:

```sql
CREATE TABLE artists_backup(
   ArtistId INTEGER PRIMARY KEY AUTOINCREMENT,
   Name NVARCHAR
);
```

To insert data into the artists_backup table with the data from the artists table, you use the INSERT INTO SELECT statement as follows:
```sql
INSERT INTO artists_backup 
SELECT ArtistId, Name
FROM artists;
```


If you query data from the artists_backup table, you will see all data in the artists table.

```sql
SELECT * FROM artists_backup;
```


## Update From
UPDATE FROM statement allows you to update data in one table based on data from another table.

The UPDATE FROM statement is often referred to as the UPDATE JOIN because it involves two tables.

```sql
UPDATE target_table
SET
	column1 = value1,
	column2 = value2
FROM
	source_table
[WHERE
	condition];
```

In this syntax:
+ First, specify the table to update in the UPDATE clause.
+ Second, set the columns in the target table to the specified values in the SET clause.
+ Third, specify the second table or a subquery from which the data is retrieved for updating the target table in the FROM clause
+ Finally, specify a condition in the WHERE clause to filter the rows to be updated.


#### Using a table in the SQLite UPDATE FROM statement
```sql
CREATE TABLE sales_employees (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL, 
    salary REAL NOT NULL
);

CREATE TABLE sales_performances (
    sales_employee_id INT PRIMARY KEY,
    score INTEGER NOT NULL CHECK (score BETWEEN 1 AND 5),
    FOREIGN KEY (sales_employee_id) REFERENCES sales_employees(id)
);

INSERT INTO sales_employees (name, salary) VALUES
  ('John Doe', 3000.0),
  ('Jane Smith', 3200.0),
  ('Michael Johnson', 2800.0);

INSERT INTO sales_performances (sales_employee_id, score) VALUES
  (1, 3), (2, 4), (3, 2);
```

Increase the salary of sales employees based on their performance scores:

```sql
UPDATE sales_employees AS e
SET
  salary = CASE s.score
    WHEN 1 THEN salary * 1.02 2% increase for score 1
    WHEN 2 THEN salary * 1.04 4% increase for score 2
    WHEN 3 THEN salary * 1.06 6% increase for score 3
    WHEN 4 THEN salary * 1.08 8% increase for score 4
    WHEN 5 THEN salary * 1.10 10% increase for score 5
  END
FROM
  sales_performances AS s
WHERE
  e.id = s.sales_employee_id;
```

Verify

```sql
SELECT * FROM sales_employees;
```




#### Using a subquery in the UPDATE FROM statement
```sql
CREATE TABLE inventory (
    item_id INTEGER PRIMARY KEY,
    item_name TEXT NOT NULL,
    quantity INTEGER NOT NULL
);

CREATE TABLE sales (
    sales_id INTEGER PRIMARY KEY,
    item_id INTEGER,
    quantity_sold INTEGER,
    sales_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES inventory (item_id)
);

INSERT INTO inventory (item_id, item_name, quantity) VALUES
  (1, 'Item A', 100),
  (2, 'Item B', 150),
  (3, 'Item C', 200);
```

Update the inventory table based on the aggregated daily sales from the sales table:

```sql
UPDATE inventory
SET quantity = quantity - daily.qty
FROM (
    SELECT
      SUM(quantity_sold) AS qty,
      item_id
    FROM sales
    GROUP BY item_id
  ) AS daily
WHERE inventory.item_id = daily.item_id;
```
  
Verify: The output indicates that the item quantities in the inventory table have been adjusted based on the aggregated sales quantities from the sales table.

```sql
SELECT * FROM inventory;
```
  
## Delete

The SQLite DELETE statement allows you to delete one row, multiple rows, and all rows in a table. 

The syntax of the SQLite DELETE statement is as follows:

```sql
DELETE FROM table
WHERE search_condition;
```
In this syntax:
+ First, specify the name of the table which you want to remove rows after the 
DELETE FROM keywords.
+ Second, add a search condition in the WHERE clause to identify the rows to 
remove. The WHERE clause is an optional part of the DELETE statement. If you 
omit the WHERE clause, the DELETE statement will delete all rows in the table.	



Create artists backup table
```sql
CREATE TABLE artists_backup(
   artistid INTEGER PRIMARY KEY AUTOINCREMENT,
   name NVARCHAR
);
```

Populate data from the artists table:
```sql
INSERT INTO artists_backup 
SELECT artistid,name
FROM artists;
```



The following statement returns all rows from the artists_backup table:
```sql
SELECT
	artistid,
	name
FROM artists_backup;
```


We have 280 rows in the artists_backup table. To remove an artist with id 1, you use the following statement:
```sql
DELETE FROM artists_backup
WHERE artistid = 1;
```

Because we use artistid to identify the artist, the statement removed exactly 1 row. Suppose you want to delete artists whose names contain the word Santana:
```sql
DELETE FROM artists_backup
WHERE name LIKE '%Santana%';
```

There are 9 rows whose values in the name column contain the word Santana therefore, these 9 rows were deleted.


To remove all rows in the artists_backup table, you just need to omit the WHERE clause as the following statement:
```sql
DELETE FROM artists_backup;
```

## Replace
The idea of the REPLACE statement is that when a UNIQUE or PRIMARY KEY constraint violation occurs, it does the following:
+ First, delete the existing row that causes a constraint violation.
+ Second, insert a new row.
In the second step, if any constraint violation e.g., NOT NULL constraint occurs, the REPLACE statement will abort the action and roll back the transaction.
The following illustrates the syntax of the REPLACE statement.
```sql
INSERT OR REPLACE INTO table(column_list)
VALUES(value_list);
```

```sql
CREATE TABLE IF NOT EXISTS positions (
	id INTEGER PRIMARY KEY,
	title TEXT NOT NULL,
	min_salary NUMERIC
);

INSERT INTO positions (title, min_salary) VALUES 
	('DBA', 120000),
    ('Developer', 100000),
    ('Architect', 150000);
	
SELECT * FROM positions;
```

The following statement creates a unique index on the title column of the positions table to ensure that it doesn’t have any duplicate position title:
```sql
CREATE UNIQUE INDEX idx_positions_title 
ON positions (title);
```




Suppose, you want to add a position into the positions table if it does not exist, in case the position exists, update the current one.The following REPLACE statement inserts a new row into the positions table because the position title Full Stack Developer is not in the positions table.
```sql
REPLACE INTO positions (title, min_salary)
VALUES('Full Stack Developer', 140000);
```

The query will update "DBA" because it exists in the positions table
```sql
REPLACE INTO positions (title, min_salary)
VALUES('DBA', 170000);

SELECT * FROM positions;
```

First, SQLite checked the UNIQUE constraint.

Second, because this statement violated the UNIQUE constraint by trying to add the DBA title that already exists, SQLite deleted the existing row.

Third, SQLite inserted a new row with the data provided by the REPLACE statement.

Notice that the REPLACE statement means INSERT or REPLACE, not INSERT or UPDATE.

What the statement tried to do is to update the min_salary for the position with id 2, which is the developer. 
	- First, the position with id 2 already exists, the REPLACE statement removes it. 
	- Then, SQLite tried to insert a new row with two columns: ( id, min_salary). 
	- However, it violates the NOT NULL constraint of the title column. 
	- Therefore, SQLite rolls back the transaction.
	- If the title column does not have the NOT NULL constraint, the REPLACE statement will insert a new row whose the title column is NULL.

```sql
REPLACE INTO positions (id, min_salary)
VALUES(2, 110000);
```




## Upsert
- Perform upsert operations in SQLite using the ON CONFLICT clause of the INSERT statement.
- Upsert is a combination of update and insert. Upsert inserts a new row if a specified unique identifier does not exist or updates an existing row if the same identifier already exists in a table.
```sql	
INSERT INTO table_name(column_list)
VALUES(value_list)
ON CONFLICT(conflict_column) 
DO 
	UPDATE SET column_name = expression
	WHERE conflict_condition;
```	   
In this syntax:
+ The INSERT INTO ... VALUES part defines the basic insert 
statement that inserts values into a specified column of a table.
+ ON CONFLICT (conflict_colum) clause introduces the upsert 
behavior. If a conflict occurs in the conflict_column, it 
should take an action.
+ DO marks the beginning of the conflict resolution strategy.
+ UPDATE SET allows you to update existing rows when a 
conflict occurs. The optional WHERE clause defines which rows 
to update during a conflict. It is useful when you want to 
update only specific rows that meet the conflict_condition.
	

If you don’t want to take action when a conflict occurs, you can use the DO NOTHING strategy like this:
```sql
INSERT INTO table_name(column_list)
VALUES(value_list)
ON CONFLICT(conflict_column) 
DO NOTHING;
```
Exclude keyword: 
+ If you attempt to insert or update a row that causes a unique 
constraint violation specified in the ON CONFLICT clause, the DO 
clause will take over.
+ The UPDATE clause following the DO keyword can use the excluded 
keyword to access the values you were trying to insert or update.
+ For example, if a row that you want to insert into a table 
is (name, email, phone), you can access the values of the row via the excluded keyword as follows:
- excluded.name
-	excluded.email
- excluded.phone	   


Create a table called search_stats to store the searched keywords and the number of searches:

```sql
CREATE TABLE search_stats(
   id INTEGER PRIMARY KEY,
   keyword TEXT UNIQUE NOT NULL,
   search_count INT NOT NULL DEFAULT 1   
);

INSERT INTO search_stats(keyword)
VALUES('SQLite');
```


Insert a row into the search_stats table with the same keyword. 

If the keyword already exists in the table, increase the search_count by one:
```sql
INSERT INTO search_stats(keyword)
VALUES ('SQLite')
ON CONFLICT (keyword)
DO 
   UPDATE 
   SET search_count = search_count + 1;
```

Because the keyword SQLite already exists, the upsert updates the search_count value.

```sql
SELECT * FROM search_stats;
```


```sql
CREATE TABLE IF NOT EXISTS contacts (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT NOT NULL,
    effective_date  DATE NOT NULL
);

INSERT INTO contacts(name, email, phone, effective_date)
VALUES('Jane Doe', 'jane@test.com', '(408)-111-2222', '2024-04-05');

SELECT * FROM contacts;
```

Update the name, phone, and effective date if the email already exists and only update when the new effective date is later than the current effective date:

```sql
INSERT INTO contacts (name, email, phone, effective_date) VALUES
  (
    'Jane Smith',
    'jane@test.com',
    '(408)-111-3333',
    '2024-05-05'
  )
ON CONFLICT (email) DO
UPDATE
SET
  name = excluded.name,
  phone = excluded.phone,
  effective_date = excluded.effective_date
WHERE
  excluded.effective_date > contacts.effective_date;
```


Verify  
```sql
SELECT * FROM contacts;
 ``` 

__Summary__
- Upsert is a combination of insert and update.
- Upsert allows you to update an existing row or insert a new row if it doesn’t exist in the table.
- Use the excluded keyword to access the values you were trying to insert or update.

  
  

## Returning Clause
How to use the SQLite RETURNING clause to return data from the INSERT, UPDATE, and DELETE statements.
- Starting from SQLite 3.35.0, the INSERT, UPDATE, and DELETE have an optional RETURNING clause that returns the row that is inserted, 
updated, or deleted.
- Here’s the syntax of the RETURNING clause:

```sql
INSERT statement:
	INSERT INTO table_name(column_list)
	VALUES(value_list)
	RETURNING 
		expression1 AS column_alias1,  
		expression2 AS column_alias2,
		...; 
```

In this syntax:
+ First, place the RETURNING clause after the INSERT statement.
+ expression1, expression2, and so on are the columns of the inserted row. They can be expressions that involve the columns. 
Additionally, you can use column aliases to return a row with the new column name
	
If you want to return all columns of the inserted row without forming expressions or aliases, you can use the asterisk (*) shortcut:

```sql
INSERT INTO table_name(column_list)
VALUES(value_list)
RETURNING *;
```

Similarly, you can use the RETURNING clause with the UPDATE statement:

```sql
UPDATE table_name
SET column1 = value1, column2 =value2, 
WHERE condition
RETURNING 
	expression1 AS column_alias1,  
	expression2 AS column_alias2,
	...; 	
```

In this syntax, the RETURNING clause returns the modified row.

Likewise, the RETURNING clause in a delete statement returns the deleted row:			

```sql
DELETE FROM table_name
WHERE condition
RETURNING 
	expression1 AS column_alias1,  
	expression2 AS column_alias2,
	...; 
```
	
It’s important to note that for the INSERT and UPDATE statements, the RETURNING clause returns the rows after SQLite has applied the change. For the DELETE statements, the RETURNING clause returns the row before the delete.


|Statement|RETURNING|
|---|---|
|INSERT|inserted row ( after inserting)|
|UPDATE|updated row ( after updating)|
|DELETE|deleted row ( before deleting)|
			

In practice, you use the RETURNING clause to get the inserted, 
updated, and deleted row without having to issue a separate query.

```sql
CREATE TABLE bookzz(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    isbn TEXT NOT NULL,
    release_date DATE
);
```


#### Returning inserted rows
First, insert a new row into the books table and return the inserted row:

 ```sql
INSERT INTO bookzz(title, isbn, release_date)
VALUES('The Catcher in the Rye', '9780316769488', '1951-07-16')
RETURNING *;
```

In this example, the RETURNING clause returns all columns of the inserted row because of the asterisk.

Second, insert a new row into the books table and return the inserted book id:

```sql
INSERT INTO bookzz(title, isbn, release_date)
VALUES ('The Great Gatsby', '9780743273565', '1925-04-10')
RETURNING id;
```

Third, insert a new row into the books table and return the book id and release year:

```sql
INSERT INTO bookzz(title, isbn, release_date)
VALUES ('The Great Gatsby', '9780743273565', '1925-04-10')
RETURNING 
   id AS book_id, 
   strftime('%Y', release_date) AS year;
```
   
   
#### Returning updated rows
Use the UPDATE statement uses the RETURNING clause to update the ISBN of the book with id 1 and return the updated row:

```sql
UPDATE bookzz
SET isbn = '0141439512'
WHERE id = 1
RETURNING *;
```

Use the UPDATE statement uses the RETURNING clause to change the book title to uppercase and return the updated rows:

```sql
UPDATE books
SET title = UPPER(title)
RETURNING *;
```


#### Returning deleted rows
Delete a book with id 1 and return the deleted row:
```sql
DELETE FROM books
WHERE id = 1
RETURNING *;
```


Delete all rows from the books table and return multiple deleted rows:
```sql
DELETE FROM books
RETURNING *;
```


Here are some restrictions when using the RETURNING clause:
+ The RETURNING cannot be used as a subquery even though it returns a result set. It can only return data to the application.
+ If the RETURNING clause returns multiple rows, the order of rows is unspecified.
+ The RETURNING clause returns the original rows that do not reflect changes made by triggers.
+ The RETURNING clause may not contain top-level aggregate functions or window functions.
+ The RETURNING clause can only reference the table being modified. It cannot reference the table that drives the modification such as in the UPDATE FROM statement.





## SQL Transaction
How to use the SQLite transaction to ensure the integrity and reliability of the data.
- SQLite & ACID
	- SQLite is a transactional database that all changes and queries are atomic, consistent, isolated, and durable (ACID).
	- SQLite guarantees all the transactions are ACID compliant even if the transaction is interrupted by a program crash, operation system dump, or power failure to the computer.
		+ Atomic: a transaction should be atomic. It means that a change cannot be broken down into smaller ones. When you commit a transaction, either the entire transaction is applied or not.
		+ Consistent: a transaction must ensure to change the database 
		from one valid state to another. When a transaction starts and 
		executes a statement to modify data, the database becomes 
		inconsistent. However, when the transaction is committed or 
		rolled back, it is important that the transaction must keep the database consistent.
		+ Isolation: a pending transaction performed by a session must 
		be isolated from other sessions. When a session starts a 
		transaction and executes the INSERT or UPDATE statement to change the data, these changes are only visible to the current session, not others. On the other hand, the changes committed by other sessions after the transaction started should not be visible to the current session.
		+ Durable: if a transaction is successfully committed, the 
		changes must be permanent in the database regardless of the 
		condition such as power failure or program crash. On the contrary, if the program crashes before the transaction is committed, the change should not persist.

- SQLite transaction statements
	- By default, SQLite operates in auto-commit mode. It means that for each command, SQLite starts, processes, and commits the transaction automatically.


**Note:** Need to end previous transaction before starting a new transaction
```sql
END TRANSACTION; 
```


To start a transaction explicitly, you use the following steps: First, open a transaction by issuing the BEGIN TRANSACTION command.

```sql
BEGIN TRANSACTION;
```


After executing the statement BEGIN TRANSACTION, the transaction is open until it is explicitly committed or rolled back.

Second, issue SQL statements to select or update data in the database. Note that the change is only visible to the current session (or client).


Commit the changes to the database by using the COMMIT or COMMIT TRANSACTION statement.
```sql
COMMIT;
```


If you do not want to save the changes, you can roll back using the ROLLBACK or ROLLBACK TRANSACTION statement:
```sql
ROLLBACK;
```


The accounts table stores data about the account numbers and their balances. The account_changes table stores the changes of the accounts.

```sql
CREATE TABLE accounts ( 
	account_no INTEGER NOT NULL, 
	balance DECIMAL NOT NULL DEFAULT 0,
	PRIMARY KEY(account_no),
        CHECK(balance >= 0)
);

CREATE TABLE account_changes (
	change_no INT NOT NULL PRIMARY KEY,
	account_no INTEGER NOT NULL, 
	flag TEXT NOT NULL, 
	amount DECIMAL NOT NULL, 
	changed_at TEXT NOT NULL 
);

INSERT INTO accounts (account_no,balance)
VALUES (100,20100);
INSERT INTO accounts (account_no,balance)
VALUES (200,10100);
SELECT * FROM accounts;
SELECT * FROM account_changes;
```


Transfer 1000 from account 100 to 200, and log the changes to the table account_changes in a single transaction.

```sql
BEGIN TRANSACTION;
UPDATE accounts
   SET balance = balance - 1000
   WHERE account_no = 100;
UPDATE accounts
   SET balance = balance + 1000
   WHERE account_no = 200;
INSERT INTO account_changes(change_no,account_no,flag,amount,changed_at) 
   VALUES(111,100,'-',1000,datetime('now'));
INSERT INTO account_changes(change_no,account_no,flag,amount,changed_at) 
   VALUES(222,200,'+',1000,datetime('now'));
COMMIT;
```

```sql
SELECT * FROM accounts;
SELECT * FROM account_changes;
```


Let’s take another example of rolling back a transaction. First, attempt to deduct 20,000 from account 100:

```sql
BEGIN TRANSACTION;

UPDATE accounts
   SET balance = balance - 20000
 WHERE account_no = 100;

INSERT INTO account_changes(account_no,flag,amount,changed_at) 
VALUES(100,'-',20000,datetime('now'));
```

SQLite issued an error due to not enough balance 


Second, roll back the transaction by using the ROLLBACK statement:
 ```sql
ROLLBACK;
```

Finally, query data from the account_changes table, you will see that the change no #3 is not there anymore:

 ```sql
SELECT * FROM account_changes;
```


## SQL Full Text Search

SQLite full-text search feature by using the FTS5 virtual table module.
- A virtual table is a custom extension to SQLite. A virtual table is like a normal table. The difference between a virtual table and a normal table is where the data come from i.e., when you process a normal table, SQLite accesses the database file to retrieve data. However, when you access a virtual table, SQLite calls the custom code to get the data. The custom code can have specified logic to handle certain tasks such as getting data from multiple data sources.
- To use full-text search in SQLite, you use FTS5 virtual table module.
- The following CREATE VIRTUAL TABLE statement creates an FTS5 table with two columns:

```sql
CREATE VIRTUAL TABLE table_name 
USING FTS5(column1,column2...);
```

Notice that you cannot add types, constraints, or PRIMARY KEY declaration in the CREATE VIRTUAL TABLE statement for creating an FTS5 table. If you do so, SQLite will issue an error.

Like creating a normal table without specifying the primary key column, SQLite adds an implicit rowid column to the FTS5 table.	


The following example creates an FTS5 table named posts with two columns title and body.	

 ```sql
CREATE VIRTUAL TABLE posts 
USING FTS5(title, body);
```

Similar to a normal table, you can insert data into the posts table as follows:
 ```sql
INSERT INTO posts(title,body) VALUES
('Learn SQlite FTS5','This tutorial teaches you how to perform full-text search in SQLite using FTS5'),
('Advanced SQlite Full-text Search','Show you some advanced techniques in SQLite full-text searching'),
('SQLite Tutorial','Help you learn SQLite quickly and effectively');
```

```sql
SELECT * FROM posts;
```



#### Querying data using full-text search
You can execute a full-text query against an FTS5 table using one of these three ways.

First, use a MATCH operator in the WHERE clause of the SELECT statement. For example, to get all rows that have the term fts5, you use the following query:

 ```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'fts5';
```


Second, use an equal (=) operator in the WHERE clause of the SELECT statement. The following statement returns the same result as the statement above:

 ```sql
SELECT * 
FROM posts 
WHERE posts = 'fts5';
```


Third, use a tabled-value function syntax. In this way, you use the search term as the first table argument:

 ```sql
SELECT * 
FROM posts('fts5');
```


By default, FTS5 is case-independent. It treats the terms fts5FTS5 and Fts5 the same. To sort the search results from the most to least relevant, you use the ORDER BY clause as follows:

 ```sql
SELECT * FROM posts 
WHERE posts MATCH 'text' 
ORDER BY rank;
```




#### Using full-text query syntax
A full-text search query is made up of phrases, where each phrase is an ordered list of one or more tokens. You can use the “+” operator to concatenate two phrases as the following example:
- "learn SQLite"
- "learn + SQLite"

FTS5 determines whether a document matches a phrase if the document contains at least one subsequence of tokens that match the sequence of tokens used to construct the phrase. The following query returns all documents that match the search term: Learn SQLite:

 ```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'learn SQLite';
```




##### Prefix searches
You can use the asterisk (*) as a prefix token. When a phrase contains the asterisk (*), it will match any document that contains the token that begins with the phrase. For example, search* matches with search, searching, searches, etc. See the following example: 

 ```sql
SELECT * 
FROM posts
WHERE posts = 'search*';
```




##### Boolean operators
You can use the Boolean operator e.g., NOT, OR, or AND to combine queries.
+ q1 AND q2: matches if both q1 and q2 queries match.
+ q1 OR q2: matches if either query q1 or q2 matches.
+ q1 NOT q2: matches if query q1 matches and q2 doesn’t match.
For example, to get the documents that match the learn phrase but doesn’t match the FTS5 phrase, you use the NOT operator as follows: 

```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'learn NOT text';
```

To search for documents that match either phrase learn or text, you use the OR operator as the following example:

 ```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'learn OR text';
```

To find the documents that match both SQLite and searching, you use the AND operator as shown below:

 ```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'sqlite AND searching';
```

To change the operator precedence, you use parenthesis to group expressions. For example:

 ```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'search AND sqlite OR help';
```

The statement returns documents that match search and sqlite or help. To find the documents that match search and either sqlite or help, you use parenthesis as follows:
 ```sql
SELECT * 
FROM posts 
WHERE posts MATCH 'search AND (sqlite OR help)';
```


#### Built-in auxiliary functions
SQLite provides three built-in auxiliary functions that can be used within full-text queries on the FTS5 table.
- The bm25() returns a value that represents the accuracy of the 
current match, the lower value means a better match.
- The highlight() auxiliary function returns a copy of the text with search terms surrounded by a specified markup e.g.,<b>search term </b>
- The snippet() selects a short fragment of text in order to maximize the number of search terms it contains.


For example, the following query uses the highlight() function to decorate the search terms using the <b>tag</b>:

```sql
SELECT highlight(posts,0, '<b>', '</b>') title, 
       highlight(posts,1, '<b>', '</b>') body
FROM posts 
WHERE posts MATCH 'SQLite'
ORDER BY rank;
```



## Data Types
If you come from other database systems such as MySQL and PostgreSQL, you’ll notice that they use "static typing".

This means that when you declare a column with a specific data type, that column can store only data of the declared type.

Unlike other database systems, SQLite uses a "dynamic type system". 

In other words, the data type of a column is determined by the value stored in it, rather than by the column’s declared data type.

In addition, you don’t have to declare a specific data type for a column when creating a table.

For example, if you declare a column with the integer data type, you can still store various data types like text and BLOB without issues.

SQLite provides five primitive data types, commonly referred to as storage classes.

Storage classes describe the formats that SQLite uses to store data on disk. 

A storage class is more general than a data type; for example, the INTEGER storage 
class includes six different integer types. In many cases, you can use storage classes and data types interchangeably.

The following table illustrates five storage classes in SQLite:


|Storage Class  |Meaning  |
|---|---|
|NULL  |NULL values mean missing information or unknown.  |
|INTEGER|Integer values are whole numbers (either positive or negative). An integer can have variable sizes such as 1, 2,3, 4, or 8 bytes.|
|REAL|Real values are real numbers with decimal values that use 8-byte floats.|
|TEXT|TEXT is used to store character data. The maximum length of TEXT is unlimited. SQLite supports various character encodings.|
|BLOB|BLOB stands for a binary large object that can store any kind of data. Theoretically, the maximum size of BLOB is unlimited.|
						

SQLite determines the data type of a value based on its data type according to the following rules:
+ If a literal has no enclosing quotes and decimal point or exponent, SQLite assigns the REAL storage class.
+ If a literal is enclosed by single or double quotes, SQLite assigns the TEXT storage class.
+ If a literal has no quotes, no decimal point, and no exponent, SQLite assigns the INTEGER storage class.
+ If a literal is NULL without quotes, SQLite assigns the NULL storage class.
+ If a literal has a prefix X’…’, SQLite assigns the BLOB storage class.
		
**NOTE** SQLite does not support built-in date and time storage classes. However, you can use the TEXT, INT, or REAL to store date and time values. For detailed information on handling date and time values, check out the SQLite date and time tutorial.

SQLite provides the typeof() function that allows you to check the storage class 
of a value based on its format. See the following example:


```sql
SELECT
  TYPEOF(100),
  TYPEOF(10.0),
  TYPEOF('100'),
  TYPEOF(x'1000'),
  TYPEOF(NULL);
```

A single column in SQLite can store mixed data types

```sql
CREATE TABLE test_datatypes (
   id INTEGER PRIMARY KEY, 
   val
);

INSERT INTO test_datatypes (val) VALUES
  (1), (2), (10.1), (20.5), ('A'),
  ('B'), (NULL), (x'0010'), (x'0011');
```
  
  
Use the typeof() function to get the data type of each value stored in the val column.
```sql
SELECT id, val, typeof (val)
FROM test_datatypes;
```



You may ask how SQLite sorts data in a column with different storage classes like val column above.

To resolve this, SQLite provides the following set of rules when it comes to sorting:
+ NULL storage class has the lowest value. It is lower than any other 
value. Between NULLs, there is no order.
+ The next higher storage classes are INTEGER and REAL. SQLite compares 
INTEGER and REAL numerically.
+ The next higher storage class is TEXT. SQLite uses the collation of 
TEXT values when comparing the TEXT values.
+ The highest storage class is the BLOB. SQLite uses the C function 
memcmp() to compare BLOB values.
		
When you use the ORDER BY clause to sort the data in a column with different storage classes, SQLite performs the following steps:
+ First, group values based on storage class: NULL, INTEGER, and REAL, 
TEXT, and BLOB.
+ Second, sort the values in each group.


The following statement sorts the mixed data in the val column of the test_datatypes table:
```sql
SELECT id, val, typeof (val)
FROM test_datatypes
ORDER BY val;
```



##### SQLite manifest typing & type affinity
Other important concepts related to SQLite data types are manifest typing and type affinity:
+ Manifest typing means that a data type is a property of a value stored in a column, rather than a property of the column itself. SQLite uses manifest typing to store values of any type in a column.
+ Type affinity of a column refers to the recommended type for data stored in that column. Please note that this is a recommendation rather than an enforcement. Therefore, a column can store values of any type.



##### Summary
- SQLite uses a dynamic type system in which you can store a value of any type in a column.
- SQLite offers five storage classes including INTEGER, REAL, TEXT, BLOB, and NULL.
- Use the typeof() function to check the storage class of a value.
- Manifest typing means a data type is an attribute of a value rather than a property of a table column.
- Type affinity refers to the recommended type of a column.






## Blob
- BLOB stands for Binary Large Object. In SQLite, you can use the BLOB data type to store binary data such as images, video files, or any raw binary data.
- Typically, you’ll use an external program to read a file such as an image, and insert the binary into a SQLite database.

```sql
CREATE TABLE documents(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    data BLOB NOT NULL  binary data
);
```

For the demonstration, we’ll use Python to read the binary data from an image file, insert it into an SQLite database, retrieve the BLOB data back, and write the BLOB data as an image.

``` python
	import sqlite3

	# Connect to an sqlite database
	conn = sqlite3.connect('my.db')
	cursor = conn.cursor()

	# Create the documents table
	cursor.execute('''CREATE TABLE IF NOT EXISTS documents(
						id INTEGER PRIMARY KEY,
						title VARCHAR(255) NOT NULL,
						data BLOB NOT NULL
					);''')

	# Read data from image.jpg and insert
	with open('image.jpg', 'rb') as file:
		image_data = file.read()
		cursor.execute("INSERT INTO documents (title, data) VALUES (?,?)", ('JPG Image',image_data,))

	# Retrieve binary data (blob)
	cursor.execute("SELECT data FROM documents WHERE id = 1")
	data = cursor.fetchone()[0]

	# write the BLOB data into an image file with the name stored_image.jpg:
	with open('stored_image.jpg', 'wb') as file:
		file.write(data)

	# Commit changes and close the database connection
	conn.commit()
	conn.close()
```




## Date & Time
SQLite does not support built-in date and/or time storage class. Instead, it leverages some built-in date and time functions to use other storage classes such as TEXT, REAL, or INTEGER for storing the date and time values.

If you use the TEXT storage class to store date and time value, you need to use the ISO8601 string format as follows:
- YYYY-MM-DD HH:MM:SS.SSS
-	2016-01-01 10:20:05.123


#### Using the TEXT storage class for storing SQLite date and time

```sql
CREATE TABLE datetime_text(
   d1 text, 
   d2 text
);
```


The table contains two column d1 and d2 with TEXT datatype.

To insert date and time values into the datetime_text table, you use the DATETIME function.

For example, to get the current UTC date and time value, you pass the now literal string to the function as follows:

```sql
SELECT datetime('now');
```

To get the local time, you pass an additional argument localtime.

```sql
SELECT datetime('now','localtime');
```

Second, insert the date and time values into the datetime_text table as follows:

```sql
INSERT INTO datetime_text (d1, d2)
VALUES(datetime('now'),datetime('now', 'localtime'));
```

Query the datetime_text TABLE

```sql
SELECT 
	d1, typeof(d1),
	d2, typeof(d2)
FROM datetime_text;
```





#### Using INTEGER to store SQLite date and time values
Besides  TEXT and REAL storage classes, you can use the INTEGER storage class to store date and time values.

We typically use the INTEGER to store UNIX time which is the number of seconds since 1970-01-01 00:00:00 UTC. See the following example:

```sql
CREATE TABLE datetime_int (d1 int);

INSERT INTO datetime_int (d1)
VALUES(strftime('%s','now'));
```

Third, query data from the datetime_int table.
SELECT d1 FROM datetime_int;  return integer

To format the result, you can use the built-in datetime() function as follows:
```sql
SELECT datetime(d1,'unixepoch') FROM datetime_int;
```




## JSON
SQLite does not have a built-in JSON data type. However, you can use the TEXT data type to store JSON data.
Additionally, SQLite provides various built-in JSON functions and operators to allow you to effectively manipulate JSON data.

In the products table:
+ id is the primary key column.
+ name column stores the product names.
+ details column uses the TEXT data type to store JSON data.

```sql
CREATE TABLE products (
    id      INTEGER PRIMARY KEY,
    name    TEXT NOT NULL,
    details TEXT NOT NULL
);
```

Inserts JSON data into details columns of the products table:
```sql
INSERT INTO products (name, details) VALUES ('iPhone 13', '{"category":
"Electronics", "price": 999, "colors": ["Black", "Blue", "White"]}'), ('Samsung
Galaxy S21', '{"category": "Electronics", "price": 899, "colors":
["Phantom Black", "Phantom Silver"]}'), ('Nike Air Force 1', '{"category":
"Shoes", "price": 100, "colors": ["White", "Black"]}'), ('Adidas Ultraboost',
'{"category": "Shoes", "price": 180, "colors":
["Core Black", "Cloud White"]}'), ('MacBook Pro', '{"category": "Electronics",
"price": 1299, "colors": ["Silver", "Space Gray"]}'), ('Amazon Kindle',
'{"category": "Electronics", "price": 79, "colors": ["Black"]}'), ('Sony
PlayStation 5', '{"category": "Electronics", "price": 499, "colors":
["White"]}'), ('Cuisinart Coffee Maker', '{"category": "Home & Kitchen",
"price": 99, "colors": ["Stainless Steel", "Black"]}'), ('Dyson V11 Vacuum
Cleaner', '{"category": "Home & Kitchen", "price": 599, "colors":
["Iron", "Nickel"]}');

SELECT * FROM products;
```

	
#### Extracting values from JSON data
To extract a value from JSON data, you use the json_extract() function:

```sql
json_extract(json, path)
```
The json_extract() function extracts a value from JSON data using a specified path. The path locates the value in the JSON data you want to extract.

The following statement uses the json_extract() function to extract the price from JSON data stored in the details column of the products table:

```sql
SELECT
  name,
  json_extract (details, '$.price') AS price
FROM products;
```

#### Using the json_extract() function in the WHERE clause
The following statement retrieves the products with the category 'Electronics'. 

It compares the value extracted from the JSON data in the details column and compares it with the string 'Electronics':

```sql
SELECT name, details
FROM products
WHERE 
  json_extract (details, '$.category') = 'Electronics';
```  
  
  
#### Inserting a JSON value
To insert a value into a JSON document, you use the json_insert() function:
```sql
json_insert(json, path, value)
```
The json_insert() function inserts the value into the json using the specified path. If the path does not exist, the function creates the element. If the json element already exists, the function does not overwrite.

For example, the following statement inserts the stock attribute with the value 10 into the JSON document with id 1:

```sql
UPDATE products
SET details = json_insert (details, '$.stock', 10)
WHERE id = 1;

SELECT * FROM products
WHERE id = 1;  Verify
```


#### Updating a JSON value
To update an existing JSON value, you can use the json_replace() function:
```sql
json_replace(json, path, value)
```
The json_replace() function replaces the value specified by a path in the json data. If the value does not exist, it does not create the value.

 ```sql
UPDATE products
SET details = json_replace(details, '$.stock', 0)
WHERE id = 1;
```

 ```sql
SELECT * FROM products
WHERE id = 1;
```



#### Deleting a JSON value
To remove a json value, you use the json_remove() function:
```sql
json_remove(json, path)
```
 		
```sql
UPDATE products
SET details = json_remove(details, '$.stock')
WHERE id = 1;

SELECT * FROM products 
WHERE id = 1;  Verify
```


#### Aggregating data into a JSON array
To aggregate values into a JSON array, you use the json_group_array() function. For example, the following statement aggregates the product names with the shoe category into a JSON array:

```sql
SELECT json_group_array(name)
FROM products
WHERE json_extract (details, '$.category') = 'Shoes';
```



#### Aggregating data into a JSON object
To aggregate values into a JSON object, you use the json_group_object() function:
```sql
json_group_object(name, value)
```

For example, the following statement uses the json_group_object to aggregate product names and their ids in the Shoes category into a JSON object:

```sql
SELECT json_group_object(name, id)
FROM products
WHERE json_extract (details, '$.category') = 'Shoes';
```

##### Summary
- SQLite uses TEXT data type to store JSON data.
- Use the json_extract() function to extract values from JSON data.
- Use the json_replace() function to replace a value in JSON data.
- Use the json_remove() function to remove a value from JSON data.
- Use the json_group_array() function to aggregate values into a JSON array.
- Use the json_group_object() function to aggregate values into a JSON object.





## Attach Database
When you connect to a database, its name is main regardless of the database 
file name. In addition, you can access the temporary database that holds temporary tables and other database objects via the temp database.

Therefore, every SQLite database connection has the main database and also temp database in case you deal with temporary database objects.

To attach an additional database to the current database connection, you use the ATTACH DATABASE statement as follows:

```sql
ATTACH DATABASE file_name AS database_name;
```
			
The statement associates the database file file_name with the current database connection under the logical database name database_name.

If the database file file_name does not exist, the statement creates a new database file.
Once the additional database attached, you can refer to all objects in the database under the name database_name. For example, to refer to the people table in the contacts database, you use the contacts.people.

In case you want to create a new memory database and attach it to the current database connection, you use __:memory:__ filename.

You can attach multiple in-memory databases at the same time with a condition that each memory database must be unique.

If you specify an empty file name '', the statement creates a temporary file-backed database.

Note that SQLite automatically deletes all temporary and memory databases when the database connection is closed.		
		
First, connect to the chinook sample database using sqlite3 command as follows:

```sql
sqlite3> c:\sqlite\db\chinook.db;		
```

Next, use the .databases command to list all databases in the current database connection.
```sql
sqlite> .databases
```
	
Then, use the ATTACH DATABASE statement to create a new database named contacts and associates it in the current database connection.
```sql
sqlite> attach database 'c:\sqlite\db\contacts.db' as contacts;
```
	
Fourth, use the .database command to display all databases in the current database connection.
```sql
sqlite> .databases
```

After that, create a new table named people in the contacts database and populate data from the customers table in the main database.

```sql
sqlite> CREATE TABLE contacts.people(first_name text, last_name text);
sqlite> INSERT INTO contacts.people SELECT firstName, lastName FROM customers;
```

Notice that we referred to the people table in the contacts database using the contacts.people naming convention.

Finally, query data from the people table in the contacts database.
```sql
	SELECT * FROM contacts.people;
```


## Create Table

To create a new table in SQLite, you use CREATE TABLE statement using the following syntax:

```sql
CREATE TABLE [IF NOT EXISTS] [schema_name].table_name (
	column_1 data_type PRIMARY KEY,
   	column_2 data_type NOT NULL,
	column_3 data_type DEFAULT 0,
	table_constraints
) [WITHOUT ROWID];
```


In this syntax:

- First, specify the name of the table that you want to create after the CREATE TABLE keywords. The name of the table cannot start with sqlite_ because it is reserved for the internal use of SQLite.

- Second, use IF NOT EXISTS option to create a new table if it does not exist. Attempting to create a table that already exists without using the IF NOT EXISTS option will result in an error.

- Third, optionally specify the schema_name to which the new table belongs. The schema can be the main database, temp database or any attached database.

- Fourth, specify the column list of the table. Each column has a name, data type, and the column constraint. SQLite supports PRIMARY KEY, UNIQUE, NOT NULL, and CHECK column constraints.
Fifth, specify the table constraints such as PRIMARY KEY, FOREIGN KEY, UNIQUE, and CHECK constraints.

- Finally, optionally use the WITHOUT ROWID option. By default, a row in a table has an implicit column, which is referred to as the rowid, oid or _rowid_ column. The rowid column stores a 64-bit signed integer key that uniquely identifies the row inside the table. If you don’t want SQLite creates the rowid column, you specify the WITHOUT ROWID option. A table that contains the rowid column is known as a rowid table. Note that the WITHOUT ROWID option is only available in SQLite 3.8.2 or later.
Note that the primary key of a table is a column or a group of columns that uniquely identify each row in the table.


Suppose you have to manage contacts using SQLite.

Each contact has the following information:
- First name
- Last name
- Email
- Phone

The requirement is that the email and phone must be unique. In addition, each contact belongs to one or many groups, and each group can have zero or many contacts.

Based on these requirements, we came up with three tables:
- The contacts table that stores contact information.
- The groups table that stores group information.
- The contact_groups table that stores the relationship between contacts and groups.

The following database diagram illustrates tables: contacts groups, and contact_groups.
![contacts](https://www.sqlitetutorial.net/wp-content/uploads/2015/12/SQLite-CREATE-TABLE-example.jpg)