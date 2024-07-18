/*
- Because you cannot refer to the same table more than one in a query, you need 
to use a table alias to assign the table a different name when you use self-join.
*/


-- (1) The employees table stores not only employee data but also organizational data. 
-- The ReportsTo column specifies the reporting relationship between employees.
-- If an employee reports to a manager, the value of the ReportsTo column of the 
-- employee’s row is equal to the value of the EmployeeId column of the manager’s row. 
-- In case an employee does not report to anyone, the ReportsTo column is NULL.
SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
FROM employees e
INNER JOIN employees m ON m.employeeid = e.reportsto
ORDER BY manager;
-- Because we used the INNER JOIN clause to join the employees table to itself, 
-- the result set does not have the row whose manager column contains a NULL value.



-- (2) In case you want to query the CEO who does not report to anyone, 
-- you need to change the INNER JOIN clause to LEFT JOIN clause in the query above.
SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
FROM employees e
LEFT JOIN employees m ON m.employeeid = e.reportsto
ORDER BY manager;



-- (3) You can use the self-join technique to find the employees located in 
-- the same city as the following query:
SELECT DISTINCT
	e1.city,
	e1.firstName || ' ' || e1.lastname AS fullname
FROM employees e1
INNER JOIN employees e2 ON e2.city = e1.city 
   AND (e1.firstname <> e2.firstname AND e1.lastname <> e2.lastname)
ORDER BY e1.city;
/*
	- e1.city = e2.city to make sure that both employees located 
	in the same city
	- e.firstname <> e2.firstname AND e1.lastname <> e2.lastname 
	to ensure that e1 and e2 are not the same employee with the assumption 
	that there aren’t employees who have the same first name and last name.
*/


