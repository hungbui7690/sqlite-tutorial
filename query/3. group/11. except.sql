/*
- SQLite EXCEPT operator compares the result sets of two queries and 
returns distinct rows from the first query that are not output by the 
second query.
- This query must conform to the following rules:
	+ First, the number of columns in the select lists of both 
	queries must be the same.
	+ Second, the order of the columns and their types must 
	be comparable.
*/

-- (1) The following statement illustrates how to use the EXCEPT operator 
-- to compare result sets of two queries:
-- <1> is in t1, but not t2
SELECT c1 FROM t1
EXCEPT 
SELECT c2 FROM t2;



-- //////////////////// 
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
(1, 1, '2024-04-25'), -- Alice purchased 'To Kill a Mockingbird'
(1, 3, '2024-04-27'), -- Alice purchased 'The Great Gatsby'
(2, 2, '2024-04-26'); -- Bob purchased '1984'


-- (2) use the EXCEPT operator to find books that have not had any sales:
-- NO NEED TO JOIN on both queries
SELECT title, author, genre, price
FROM books
EXCEPT
SELECT title, author, genre, price
FROM books
JOIN purchases ON books.book_id = purchases.book_id;

/*
- The first query selects all books from the books table.
- The second query retrieves books that have orders by joining the books 
table with the orders table.
- The EXCEPT operator returns a list of distinct books that have not been 
ordered by any customer.
*/