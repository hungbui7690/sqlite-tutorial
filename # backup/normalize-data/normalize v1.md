# Data Normalization

The main benefit of normalization is that a piece of information is stored in a single place.

#### Scenario

Let's look at an example. Let's say we're designing a database for an eCommerce store that sells shoes.

One of the main items you'll store information about is the name of a product, such as a shoe called "Nike Air Max". On the website for this eCommerce store, you may need to show this in several places:

- A list of products to browse
- A person's shopping cart, which is a list of - products they have added to a cart for purchasing
- A customer's order and purchase receipt

There's a potential for this product name to be stored in many places in the database.

However, with a normalized database, the product name of Nike Air Max is only stored in one place. Any other area of the database that needs to know about the product name can refer to this specific product record.


#### Benefit
Why is this helpful? There are a few reasons:
- Making updates to a record is easier because it only needs to be done in one place
- References to the record can be changed without removing the record
- It's easier to keep a history of records over time
- It reduces the risk of data entry errors

Normalization will likely result in more tables being created and more relationships between the tables.

A common reaction to this is that it would make writing SQL queries harder, because there are more tables to think about when writing, and slower, because there are more joins used.

However, that's not necessarily the case. Here are some benefits to writing SQL on a normalized database:
- Less data is considered: with multiple smaller tables, there is less data for the database to look through and consider when returning results of a query, compared to tables with more rows and more columns.
- Performance can be optimized: there are many ways to increase the performance of queries if there are many tables used
- One place to make changes: writing Insert, Update, or Delete statements to make changes to data is easier because there's only one place to do it.

#### How to Normalize
How do you follow the process of SQL normalization?

There are several stages of the normalization process. The three main stages are:
- First normal form
- Second normal form
- Third normal form

A database is said to be normalized if it meets the rules specified in "third normal form", which is the third stage of the DBMS normalization process.

There are several further stages of SQL normalization, or database normal forms, such as Boyce Codd Normal Form and Fourth Normal Form.


#### Our Example!

Let's say we have a single product table with the following columns, and an example record:

![Image](https://i.ibb.co/JjCy1MC/1.png)

Here's the visual representation of this design in an Entity Relationship Diagram:

![Image](https://i.ibb.co/b3WgdqN/2.png)


#### 1st Normal Form

The first normal form is the first step in the process.

For a database design to be in first normal form, or 1NF
- **_each row needs to have a primary key_**
- **_each field needs to contain a single value_**

In our example:
- __Category__ column can contain several values (Men or Women or Kids), 
- __Color__ column contains several values (Black, White, Green, and many others).

We also do not have a primary key in the table.

So, *this design does not meet first normal form*.

To adhere to the first normal form, we can add a new product ID column to the table, and move the Category and Color values to separate tables.

This means our database looks like this:

![Image](https://i.ibb.co/ZMbpZDt/3.png)

This design now meets first normal form.

**_Note:_**
- Nói tóm lại, những cột nào có nhiều giá trị thì sẽ phải tạo thành 1 bảng mới.
- Ví dụ: 
  - Color: có thể có rất nhiều màu (red, green, blue, stripe...)
  - Category: Men, Kids, Woman, Students... 
- Những thằng này nếu để trong bảng products, thì mỗi một màu khác, hoặc 1 usage khác, hoặc combination giữa 2 thằng này thì sẽ phải tạo ra 1 row để lưu dữ liệu > sẽ tốn chỗ. Nhưng nếu lưu thành 1 bảng khác thì chỉ cần lưu ID của colors hoặc usage trong bảng Products mà thôi






#### 2nd Normal Form

For a database to meet second normal form, or 2NF:
- it must meet the rules of first normal form
- also **_"each non-key attribute must be functionally dependent on the primary key"_**.

This means that any column that is not the primary key needs to depend on the primary key. If it doesn't, we need to solve that.

Let's check our design.

![Image](https://i.ibb.co/ZMbpZDt/4.png)

Does each column in the product table depend on the product ID?

- **_product name_**: Yes, this is directly related to the **product ID**.
- **_usage_**: This contains values such as "Casual" or "Running", and it's **not** dependent on the product ID. It can exist separately to the product.
- **_manufacturer_**: The manufacturer does **not** depend on the product ID. A manufacturer, such as Nike, can exist independently of this Nike Air Max product.
- **_price_**: Yes, this is specific to this product.
- **_size_**: **No**, the size can exist separately from the product. 
- **_description_**: Yes, this is specific to this product.
- **_number in stock_**: Yes, this is specific to this product.

We have several attributes that are not dependent on the product ID. They should be created as separate tables:
- usage
- manufacturer
- size

We can create the tables in a similar way to the color and category tables.

Our diagram could look like this:

![Image](https://i.ibb.co/qpjbzT3/5.png)

*Another step we need to take as part of second normal form is relating our tables together*. This is done by **adding foreign keys** to tables, so that they can relate to the correct record.

Our database design currently has data in separate tables, but we still need to know which of the values in each table apply to a product. 

For example, we need to know the color of our product, even if it's in a separate table.

We do this by adding a foreign key to one of the tables.

The foreign key goes in the table that needs to refer to one record in another table. In our example, a product needs to refer to one color, so we add a foreign key into the product table, and this column will refer to the primary key in the color table. We can call this new column color ID.

![Image](https://i.ibb.co/PFyqZZD/6.png)


We can take the same approach for the other tables. The product needs to relate to the correct usage, size, category, and manufacturer records.

Our design will look like this:

![Image](https://i.ibb.co/z2H7r4j/7.png)

Our design is now in second normal form.


#### 3rd Normal Form

The next step is called third normal form. This is a common place to end the SQL normalization process, because the design allows for efficient SQL queries and addresses the issues of databases that aren't normalized.

A design will meet third normal form if it has no "transitive functional dependency".

A "transitive functional dependency" means that every attribute that is not the primary key is dependent on only the primary key.

For example, in one table:
- Column A determines Column B
- Column B determines Column C
This is a "transitive functional dependency" because Column C depends on Column B instead of Column A.

###### How do we apply this to our design?

For all of our newer smaller tables (usage, size, category, color, and manufacturer), they all meet these criteria. They only have two columns, and the second column (the name) is dependent on the first column (the ID).

Let's look at our product table. For each of our columns, are they dependent on something other than the primary key of product ID?
- **category ID**: No, this is only dependent on the product ID.
- **color ID**: No, this is only dependent on the product ID
- **usage ID**: No
- **size ID**: Maybe - we'll look at this shortly.
- __manufacturer ID__: No
- **product name**: No
- **price**: No
- **description**: No
- **number in stock**: No


What does the size ID column represent? It refers to a size of the product, such as "US Mens 9" from our example.

However, other size values could be "EU Womens 37" or "UK Mens 8". These sizes are actually dependent on whether the product is for Men or Women, so they are dependent on the category.

In our design, one way we can solve this is by removing the category ID from the product table and adding it to the size table.

Here's our updated design:

![Image](https://i.ibb.co/L03vsZn/8.png)

So, our example Nike Air Max shoe would have a size ID that relates to the size of "US Mens 9", and this size record would have a category ID that relates to the value of "Mens".

Our design now meets third normal form. Because of this, our design is said to be normalized.

If we want to enhance our design, there are some more steps or "database normal forms" that can be applied.





#### BCNF
BCNF stands for Boyce-Codd Normal Form, and it's a slightly stricter version of third normal form. It's often referred to as 3.5NF because it's close to third normal form.

A database design will meet BCNF if all redundancy based on functional dependency has been removed. This is best explained with an example.

It's uncommon that you'll find a table that is in third normal form but not in BCNF. We don't see any in our design for products.

Let's say we had a database design for a school, which had some tables for teachers and students, like this:

![Image](https://i.ibb.co/5BCGzGj/9.png)

All of the columns depend on the ID of the table.

However, we have an address in both tables. The address could be separated into its own table, and related to the teacher and student table.

Our design could look like this:

![Image](https://i.ibb.co/jZQ8hHq/10.png)

BCNF is one of the normal forms in SQL that is not used very often, but it's helpful if you want to make improvements to your design to reduce the risk of redundancy.



#### 4th Normal Form
Fourth normal form is the next level of normalization in SQL after BCNF.

Just like with BCNF, this is one of the uncommon normal forms in SQL, but it's still possible that your design can meet third normal form or BCNF but not meet fourth normal form.

The definition of fourth normal form is that "are no non-trivial multivalued dependencies other than a candidate key."

This means that any dependency between columns in the table involves a column that could be the primary key.

Let's see an example of fourth normal form.

We don't have any in our product database, so we'll use a different database normalization example for this.

Let's say we had a customer table.

Here's the design:

![Image](https://i.ibb.co/5x1WZ3D/11.png)

And here's some sample data:

| id | customer_name | operating_system | location |
|----|---------------|------------------|----------|
| 2  | John          | Windows, macOS   | Chicago  |
| 6  | Michelle      | Windows          | Boston   |
| 8  | Mark          | Linux            | Chicago  |
| 15 | Sarah         | macOS, Windows   | Atlanta  |

This table contains two pieces of information about a customer:

- the operating system that the customer uses, which can be more than one
- the location the customer is based in, which is one value

This table also shows that these two pieces of information are independent: the operating system is not dependent on or related to the location. Both of the columns are dependent on the individual customer (the ID).

It also shows that there can be multiple values for an operating system, which is an example of a multi-valued dependency.

To move this into fourth normal form, we need to separate this multi-valued dependency into a separate table.

Our design would look like this:

![Image](https://i.ibb.co/HgDXwSc/12.png)


Our sample data would look like this:

```sql
customer
| id | customer_name | location |
|----|---------------|----------|
| 2  | John          | Chicago  |
| 6  | Michelle      | Boston   |
| 8  | Mark          | Chicago  |
| 15 | Sarah         | Atlanta  |


customer_operating_system
| id | operating_system |
|----|------------------|
| 2  | Windows          |
| 2  | macOS            |
| 6  | Windows          |
| 8  | Linux            |
| 15 | macOS            |
| 15 | Windows          |
```

The multi-valued dependency has been removed, and this design is now in fourth normal form.

#### Conclusion

The SQL normalization process is a great way to improve the design of a database, by removing the risk of poor data quality, redundant data, and missing data. It also remains easy to write SQL queries against the tables to get the data you need.

The database normal forms can be summarized as:
- First normal form: each table needs a primary key
- Second normal form: any column that is not the primary key needs to depend on the primary key
- Third normal form: any column that is not the primary key is only dependent on the primary key (and no other columns)
- Boyce-Codd normal form: remove functional dependencies
- Fourth normal form: remove multi-valued dependencies

When you create or modify your database by writing SQL queries, you'll need a tool to do this. PopSQL is a great choice for this, as it helps you and your team work together on SQL and store your scripts in a central location (as well as many other helpful features).











