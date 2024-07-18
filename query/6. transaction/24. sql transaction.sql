/*
How to use the SQLite transaction to ensure the integrity and reliability 
of the data.

	SQLite & ACID
	- SQLite is a transactional database that all changes and queries are 
	atomic, consistent, isolated, and durable (ACID).
	- SQLite guarantees all the transactions are ACID compliant even if 
	the transaction is interrupted by a program crash, operation system 
	dump, or power failure to the computer.
		+ Atomic: a transaction should be atomic. It means that a change 
		cannot be broken down into smaller ones. When you commit a 
		transaction, either the entire transaction is applied or not.
		+ Consistent: a transaction must ensure to change the database 
		from one valid state to another. When a transaction starts and 
		executes a statement to modify data, the database becomes 
		inconsistent. However, when the transaction is committed or 
		rolled back, it is important that the transaction must keep the 
		database consistent.
		+ Isolation: a pending transaction performed by a session must 
		be isolated from other sessions. When a session starts a 
		transaction and executes the INSERT or UPDATE statement to change 
		the data, these changes are only visible to the current session, 
		not others. On the other hand, the changes committed by other 
		sessions after the transaction started should not be visible to 
		the current session.
		+ Durable: if a transaction is successfully committed, the 
		changes must be permanent in the database regardless of the 
		condition such as power failure or program crash. On the contrary, 
		if the program crashes before the transaction is committed, the 
		change should not persist.

	SQLite transaction statements
	- By default, SQLite operates in auto-commit mode. It means that for 
	each command, SQLite starts, processes, and commits the transaction 
	automatically.
*/


-- ////////////////////////////////
-- (1) Need to end previous transaction
END TRANSACTION; 


-- (2) To start a transaction explicitly, you use the following steps:
-- First, open a transaction by issuing the BEGIN TRANSACTION command.
BEGIN TRANSACTION;
-- After executing the statement BEGIN TRANSACTION, the transaction is 
-- open until it is explicitly committed or rolled back.
-- Second, issue SQL statements to select or update data in the database. 
-- Note that the change is only visible to the current session (or client).


-- (3) commit the changes to the database by using the COMMIT or 
-- COMMIT TRANSACTION statement.
COMMIT;


-- (4) If you do not want to save the changes, you can roll back 
-- using the ROLLBACK or ROLLBACK TRANSACTION statement:
ROLLBACK;




-- ////////////////////////////////
-- (5) The accounts table stores data about the account numbers and 
-- their balances. The account_changes table stores the changes of 
-- the accounts.
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


-- (6) Transfer 1000 from account 100 to 200, and log the changes to the 
-- table account_changes in a single transaction.
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

SELECT * FROM accounts;
SELECT * FROM account_changes;



-- ////////////////////////////////
-- (7) Let’s take another example of rolling back a transaction.
-- First, attempt to deduct 20,000 from account 100:
BEGIN TRANSACTION;

UPDATE accounts
   SET balance = balance - 20000
 WHERE account_no = 100;

INSERT INTO account_changes(account_no,flag,amount,changed_at) 
VALUES(100,'-',20000,datetime('now'));
-- SQLite issued an error due to not enough balance 


-- (8) Second, roll back the transaction by using the ROLLBACK statement:
ROLLBACK;

-- (9) Finally, query data from the account_changes table, you will see 
-- that the change no #3 is not there anymore:
SELECT * FROM account_changes;