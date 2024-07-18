## What is Database Normalization?
Normalization is a database design technique that reduces data redundancy and eliminates undesirable characteristics like Insertion, Update and Deletion Anomalies. 

Normalization rules divides larger tables into smaller tables and links them using relationships. The purpose of Normalization in SQL is to *eliminate redundant (repetitive) data* and ensure data is stored logically.

The inventor of the relational model Edgar Codd proposed the theory of normalization of data with the introduction of the First Normal Form, and he continued to extend theory with Second and Third Normal Form. Later he joined Raymond F. Boyce to develop the theory of Boyce-Codd Normal Form.


## Types of Normal Forms in DBMS

Here is a list of Normal Forms in SQL:

- **1NF (First Normal Form)**: Ensures that the database table is organized such that each column contains atomic (indivisible) values, and each record is unique. This eliminates repeating groups, thereby structuring data into tables and columns.
- **2NF (Second Normal Form)**: Builds on 1NF by remove redundant data from a table that is being applied to multiple rows. and placing them in separate tables. It requires all non-key attributes to be fully functional on the primary key.
- **3NF (Third Normal Form)**: Extends 2NF by ensuring that all non-key attributes are not only fully functional on the primary key but also independent of each other. This eliminates transitive dependency.
- **BCNF (Boyce-Codd Normal Form)**: A refinement of 3NF that addresses anomalies not handled by 3NF. It requires every determinant to be a candidate key, ensuring even stricter adherence to normalization rules.
- **4NF (Fourth Normal Form)**: Addresses multi-valued dependencies. It ensures that there are no multiple independent multi-valued facts about an entity in a record.
- **5NF (Fifth Normal Form)**: Also known as “Projection-Join Normal Form” (PJNF), It pertains to the reconstruction of information from smaller, differently arranged data pieces.
- **6NF (Sixth Normal Form)**: Theoretical and not widely implemented. It deals with temporal data (handling changes over time) by further decomposing tables to eliminate all non-temporal redundancy.

The Theory of Data Normalization in MySQL server is still being developed further. For example, there are discussions even on 6th Normal Form. However, in most practical applications, normalization achieves its best in 3rd Normal Form. The evolution of Normalization in SQL theories is illustrated below-

![image](https://i.ibb.co/Z6s0CT2/1.png)



## Database Normalization With Examples
Database Normalization Example can be easily understood with the help of a case study. 

Assume, a video library maintains a database of movies rented out. Without any normalization in database, all information is stored in one table as shown below. 

Let’s understand Normalization database with normalization example with solution:

![image](https://i.ibb.co/dg34tD3/2.png)



Here you see Movies Rented column has multiple values. Now let’s move into 1st Normal Forms:

### First Normal Form (1NF)
- Each table cell should contain a single value.
- Each record needs to be unique.

The _above table is in in 1NF_


#### 1NF Example

![image](https://i.ibb.co/PC8HzxL/3.png)

Before we proceed let’s understand a few things —

##### What is a KEY in SQL

A **KEY in SQL** is a value used to identify records in a table uniquely. An SQL KEY is a *single column* or *combination of multiple columns* used to uniquely identify rows or tuples in the table. SQL Key is used to identify duplicate information, and it also helps establish a relationship between multiple tables in the database.

Note: Columns in a table that are NOT used to identify a record uniquely are called non-key columns.

##### What is a Primary Key?

![image](https://i.ibb.co/s2yLPPJ/4.png)

A primary is a single column value used to identify a database record uniquely.

It has following attributes
- A primary key cannot be NULL
- A primary key value must be unique
- The primary key values should rarely be changed
- The primary key must be given a value when a new record is inserted.


##### What is Composite Key?
A composite key is a primary key composed of multiple columns used to identify a record uniquely

In our database, we have two people with the same name Robert Phil, but they live in different places.

![image](https://i.ibb.co/QXxJYnP/5.png)


Hence, we require both Full Name and Address to identify a record uniquely. That is a composite key.

Let’s move into second normal form 2NF

#### Second Normal Form (2NF)
- Rule 1- Be in 1NF
- Rule 2- Single Column Primary Key that does not functionally dependent on any subset of candidate key relation 

It is clear that we can’t move forward to make our simple database in 2nd Normalization form unless we partition the table above.

![image](https://i.ibb.co/DC0S2N0/6.png)

![image](https://i.ibb.co/DM9TGHv/7.png)

We have divided our 1NF table into two tables viz. Table 1 and Table2. Table 1 contains member information. Table 2 contains information on movies rented.

We have introduced a new column called Membership_id which is the primary key for table 1. Records can be uniquely identified in Table 1 using membership id

#### Database – Foreign Key
In Table 2, Membership_ID is the Foreign Key

![image](https://i.ibb.co/FsP1h51/8.png)

![image](https://i.ibb.co/CbQRgQG/2024-06-28-004949.png)


Foreign Key references the primary key of another Table! It helps connect your Tables
- A foreign key can have a different name from its primary key
- It ensures rows in one table have corresponding rows in another
- Unlike the Primary key, they do not have to be unique. Most often they aren’t
- Foreign keys can be null even though primary keys can not

![image](https://i.ibb.co/wBHPtWG/10.png)


#### Why do you need a foreign key?

Suppose, a novice inserts a record in Table B such as

![image](https://i.ibb.co/nbpg363/11.png)

You will only be able to insert values into your foreign key that exist in the unique key in the parent table. This helps in referential integrity.

The above problem can be overcome by declaring membership id from Table2 as foreign key of membership id from Table1

Now, if somebody tries to insert a value in the membership id field that does not exist in the parent table, an error will be shown!



#### What are transitive functional dependencies?
A transitive functional dependency is when changing a non-key column, might cause any of the other non-key columns to change

Consider the table 1. Changing the non-key column Full Name may change Salutation.

![image](https://i.ibb.co/TByg0zZ/12.png)

Let’s move into 3NF

### Third Normal Form (3NF)
- Rule 1- Be in 2NF
- Rule 2- Has no transitive functional dependencies

To move our 2NF table into 3NF, we again need to again divide our table.


#### 3NF Example

Below is a 3NF example in SQL database:

![image](https://i.ibb.co/g6Ld776/13.png)
![image](https://i.ibb.co/Tkjf6Ww/14.png)
![image](https://i.ibb.co/zxmdk52/15.png)


We have again divided our tables and created a new table which stores Salutations.

There are no transitive functional dependencies, and hence our table is in 3NF

In Table 3 Salutation ID is primary key, and in Table 1 Salutation ID is foreign to primary key in Table 3

Now our little example is at a level that cannot further be decomposed to attain higher normal form types of normalization in DBMS. 

In fact, it is already in higher normalization forms. Separate efforts for moving into next levels of normalizing data are normally needed in complex databases. 

However, we will be discussing next levels of normalization in DBMS in brief in the following.

### Boyce-Codd Normal Form (BCNF)
Even when a database is in 3rd Normal Form, still there would be anomalies resulted if it has more than one Candidate Key.

Sometimes is BCNF is also referred as 3.5 Normal Form.

### Fourth Normal Form (4NF)
If no database table instance contains two or more, independent and multivalued data describing the relevant entity, then it is in 4th Normal Form.

### Fifth Normal Form (5NF)
A table is in 5th Normal Form only if it is in 4NF and it cannot be decomposed into any number of smaller tables without loss of data.

### Sixth Normal Form (6NF) Proposed
6th Normal Form is not standardized, yet however, it is being discussed by database experts for some time. Hopefully, we would have a clear & standardized definition for 6th Normal Form in the near future…

### Advantages of Normal Form
- **Improve Data Consistency**: Normalization ensures that each piece of data is stored in only one place, reducing the chances of inconsistent data. When data is updated, it only needs to be updated in one place, ensuring consistency.
- ***Reduce Data Redundancy***: Normalization helps eliminate duplicate data by dividing it into multiple, related tables. This can save storage space and also make the database more efficient.
- **Improve Query Performance**: Normalized databases are often easier to query. Because data is organized logically, queries can be optimized to run faster.
- **Make Data More Meaningful**: Normalization involves grouping data in a way that makes sense and is intuitive. This can make the database easier to understand and use, especially for people who didn’t design the database.
- **Reduce the Chances of Anomalies**: Anomalies are problems that can occur when adding, updating, or deleting data. Normalization can reduce the chances of these anomalies by ensuring that data is logically organized.


### Disadvantages of Normalization
- **Increased Complexity**: Normalization can lead to complex relations. An extensive number of tables with foreign keys can be difficult to manage, leading to confusion.
- **Reduced Flexibility**: Due to the strict rules of normalization, there might be less flexibility in storing data that doesn’t adhere to these rules.
- **Increased Storage Requirements**: While normalization reduces redundancy, It may be necessary to allocate more storage space to accommodate the additional tables and indices.
- **Performance Overhead**: Joining multiple tables can be costly in terms of performance. The more normalized the data, the more joins are needed, which can slow down data retrieval times.
- **Loss of Data Context**: Normalization breaks down data into separate tables, which can lead to a loss of business context. Examining related tables is necessary to understand the context of a piece of data.
- **Need for Expert Knowledge**: Implementing a normalized database requires a deep understanding of the data, the relationships between data, and the normalization rules. This requires expert knowledge and can be time-consuming.

That’s all to SQL Normalization!!!

### Conclusion
- Database designing is critical to the successful implementation of a database management system that meets the data requirements of an enterprise system.
- Normalization in DBMS is a process which helps produce database systems that are cost-effective and have better security models.
- Functional dependencies are a very important component of the normalize data process
- Most database systems are normalized database up to the third normal forms in DBMS.
- A primary key uniquely identifies are record in a Table and cannot be null
- A foreign key helps connect table and references a primary key

