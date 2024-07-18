-- If you use a LEFT JOIN, INNER JOIN, or CROSS JOIN without the ON or USING clause, SQLite 
-- produces a cartesian product of the involved tables. The number of rows in the cartesian 
-- product is the product of the number of rows in each table.
-- **NOTE**: no join condition when using CROSS JOIN


CREATE TABLE ranks (RANK TEXT NOT NULL);
CREATE TABLE suits (suit TEXT NOT NULL);
INSERT INTO ranks (RANK) VALUES
  ('2'),('3'),('4'),('5'),('6'),('7'),
  ('8'),('9'),('10'),('J'),('Q'),('K'),('A');
INSERT INTO suits (suit) VALUES
  ('Clubs'),('Diamonds'),('Hearts'),('Spades');
  
  
  
-- 1. The following statement uses the CROSS JOIN clause to return a 
-- complete deck of cards data:
SELECT
  RANK,
  suit
FROM
  ranks
  CROSS JOIN suits
ORDER BY
  suit;