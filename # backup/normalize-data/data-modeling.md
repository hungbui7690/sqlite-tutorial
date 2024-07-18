## ER (Entity Relationship) Diagram in DBMS
- ER model stands for an Entity-Relationship model. It is a high-level data model. This model is used to define the data elements and relationship for a specified system.
- It develops a conceptual design for the database. It also develops a very simple and easy to design view of data.
- In ER modeling, the database structure is portrayed as a diagram called an entity-relationship diagram.

**For example**, Suppose we design a school database. In this database, the student will be an entity with attributes like address, name, id, age, etc. The address can be another entity with attributes like city, street name, pin code, etc and there will be a relationship between them.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept.png)


## Component of ER Diagram

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept-diagram.png)


#### 1. Entity:
An entity may be any object, class, person or place. In the ER diagram, an entity can be represented as rectangles.

Consider an organization as an example- manager, product, employee, department etc. can be taken as an entity.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept2.png)


##### a. Weak Entity

An entity that depends on another entity called a weak entity. The weak entity doesn't contain any key attribute of its own. The weak entity is represented by a double rectangle.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept3.png)


#### 2. Attribute
The attribute is used to describe the property of an entity. Eclipse is used to represent an attribute.

**For example**, id, age, contact number, name, etc. can be attributes of a student.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept4.png)


##### a. Key Attribute

The key attribute is used to represent the main characteristics of an entity. It represents a primary key. The key attribute is represented by an ellipse with the text underlined.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept5.png)


##### b. Composite Attribute

An attribute that composed of many other attributes is known as a composite attribute. The composite attribute is represented by an ellipse, and those ellipses are connected with an ellipse.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept6.png)

##### c. Multivalued Attribute

An attribute can have more than one value. These attributes are known as a multivalued attribute. The double oval is used to represent multivalued attribute.

**For example**, a student can have more than one phone number.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept7.png)

##### d. Derived Attribute

An attribute that can be derived from other attribute is known as a derived attribute. It can be represented by a dashed ellipse.

**For example**, A person's age changes over time and can be derived from another attribute like Date of birth.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept8.png)


#### 3. Relationship
A relationship is used to describe the relation between entities. Diamond or rhombus is used to represent the relationship.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept9.png)

Types of relationship are as follows:

##### a. One-to-One Relationship

When only one instance of an entity is associated with the relationship, then it is known as one to one relationship.

**For example**, A female can marry to one male, and a male can marry to one female.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept10.png)


##### b. One-to-many relationship

When only one instance of the entity on the left, and more than one instance of an entity on the right associates with the relationship then this is known as a one-to-many relationship.

**For example**, Scientist can invent many inventions, but the invention is done by the only specific scientist.
![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept11.png)

##### c. Many-to-one relationship

When more than one instance of the entity on the left, and only one instance of an entity on the right associates with the relationship then it is known as a many-to-one relationship.

**For example**, Student enrolls for only one course, but a course can have many students.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept12.png)

##### d. Many-to-many relationship

When more than one instance of the entity on the left, and more than one instance of an entity on the right associates with the relationship then it is known as a many-to-many relationship.

For example, Employee can assign by many projects and project can have many employees.

![image](https://static.javatpoint.com/dbms/images/dbms-er-model-concept13.png)



## Notation of ER diagram
Database can be represented using the notations. In ER diagram, many notations are used to express the cardinality. These notations are as follows:


![image](https://static.javatpoint.com/dbms/images/dbms-notation-of-er-diagram.png)




## Cardinality in DBMS (Mapping Constraints)
### DBMS

DBMS stands for Database Management System, which is a tool, or a software used to do various operations on a Database like the Creation of the Database, Deletion of the Database, or Updating the current Database. To simplify processing and data querying, the most popular types of Databases currently in use typically model their data as rows and columns in a set of tables. The data may then be handled, updated, regulated, and structured with ease. For writing and querying data, most Databases employ Structured Query Language (SQL).

### Cardinality

Cardinality means how the entities are arranged to each other or what is the relationship structure between entities in a relationship set. In a Database Management System, Cardinality represents a number that denotes how many times an entity is participating with another entity in a relationship set. The Cardinality of DBMS is a very important attribute in representing the structure of a Database. In a table, the number of rows or tuples represents the Cardinality.

### Cardinality Ratio
Cardinality ratio is also called Cardinality Mapping, which represents the mapping of one entity set to another entity set in a relationship set. We generally take the example of a binary relationship set where two entities are mapped to each other.

Cardinality is very important in the Database of various businesses. For example, if we want to track the purchase history of each customer then we can use the one-to-many cardinality to find the data of a specific customer. The Cardinality model can be used in Databases by Database Managers for a variety of purposes, but corporations often use it to evaluate customer or inventory data.

There are four types of Cardinality Mapping in Database Management Systems:
1. One to one
2. Many to one
3. One to many
4. Many to many


#### One to One
One to one cardinality is represented by a 1:1 symbol. In this, there is at most one relationship from one entity to another entity. There are a lot of examples of one-to-one cardinality in real life databases.

**For example**, one student can have only one student id, and one student id can belong to only one student. So, the relationship mapping between student and student id will be one to one cardinality mapping.

Another example is the relationship between the director of the school and the school because one school can have a maximum of one director, and one director can belong to only one school.

`
Note: it is not necessary that there would be a mapping for all entities in an entity set in one-to-one cardinality. Some entities cannot participate in the mapping.
`
![image](https://static.javatpoint.com/dbms/images/dbms-mapping-constraints.png)





#### Many to One Cardinality:
In many to one cardinality mapping, from set 1, there can be multiple sets that can make relationships with a single entity of set 2. Or we can also describe it as from set 2, and one entity can make a relationship with more than one entity of set 1.

One to one Cardinality is the subset of Many to one Cardinality. It can be represented by M:1.

**For example**, there are multiple patients in a hospital who are served by a single doctor, so the relationship between patients and doctors can be represented by Many to one Cardinality.


![image](https://static.javatpoint.com/dbms/images/dbms-mapping-constraints2.png)



#### One to Many Cardinalities:
In One-to-many cardinality mapping, from set 1, there can be a maximum single set that can make relationships with a single or more than one entity of set 2. Or we can also describe it as from set 2, more than one entity can make a relationship with only one entity of set 1.

One to one cardinality is the subset of One-to-many Cardinality. It can be represented by 1: M.

**For Example**, in a hospital, there can be various compounders, so the relationship between the hospital and compounders can be mapped through One-to-many Cardinality.

![image](https://static.javatpoint.com/dbms/images/dbms-mapping-constraints3.png)



#### Many to Many Cardinalities:
In many, many cardinalities mapping, there can be one or more than one entity that can associate with one or more than one entity of set 2. In the same way from the end of set 2, one or more than one entity can make a relation with one or more than one entity of set 1.

It is represented by **M: N** or **N: M**.

One to one cardinality, One to many cardinalities, and Many to one cardinality is the subset of the many to many cardinalities.

**For Example**, in a college, multiple students can work on a single project, and a single student can also work on multiple projects. So, the relationship between the project and the student can be represented by many to many cardinalities.


![image](https://static.javatpoint.com/dbms/images/dbms-mapping-constraints4.png)


#### Appropriate Mapping Cardinality
Evidently, the real-world context in which the relation set is modeled determines the Appropriate Mapping Cardinality for a specific relation set.

- We can combine relational tables with many involved tables if the Cardinality is one-to-many or many-to-one.
- One entity can be combined with a relation table if it has a one-to-one relationship and total participation, and two entities can be combined with their relation to form a single table if both of them have total participation.
- We cannot mix any two tables if the Cardinality is many-to-many.







## Keys
- Keys play an important role in the relational database.
- It is used to uniquely identify any record or row of data from the table. It is also used to establish and identify relationships between tables.

**For example**, ID is used as a key in the Student table because it is unique for each student. In the PERSON table, passport_number, license_number, SSN are keys since they are unique for each person.

![image](https://static.javatpoint.com/dbms/images/dbms-keys1.png)


#### Types of keys:

![image](https://static.javatpoint.com/dbms/images/dbms-keys2.png)


##### 1. Primary key
- It is the first key used to identify one and only one instance of an entity uniquely. An entity can contain multiple keys, as we saw in the PERSON table. The key which is most suitable from those lists becomes a primary key.
- In the EMPLOYEE table, ID can be the primary key since it is unique for each employee. In the EMPLOYEE table, we can even select License_Number and Passport_Number as primary keys since they are also unique.
- For each entity, the primary key selection is based on requirements and developers.

![image](https://static.javatpoint.com/dbms/images/dbms-keys3.png)


##### 2. Candidate key
A candidate key is an attribute or set of attributes that can uniquely identify a tuple.
Except for the primary key, the remaining attributes are considered a candidate key. The candidate keys are as strong as the primary key.

**For example**: In the EMPLOYEE table, id is best suited for the primary key. The rest of the attributes, like SSN, Passport_Number, License_Number, etc., are considered a candidate key.



![image](https://static.javatpoint.com/dbms/images/dbms-keys4.png)





##### 3. Super Key
Super key is an attribute set that can uniquely identify a tuple. A super key is a superset of a candidate key.

![image](https://static.javatpoint.com/dbms/images/dbms-keys5.png)

**For example**: In the above EMPLOYEE table, for(EMPLOEE_ID, EMPLOYEE_NAME), the name of two employees can be the same, but their EMPLYEE_ID can't be the same. Hence, this combination can also be a key.

The super key would be EMPLOYEE-ID (EMPLOYEE_ID, EMPLOYEE-NAME), etc.

##### 4. Foreign key
- Foreign keys are the column of the table used to point to the primary key of another table.
- Every employee works in a specific department in a company, and employee and department are two different entities. So we can't store the department's information in the employee table. - - - That's why we link these two tables through the primary key of one table.
- We add the primary key of the DEPARTMENT table, Department_Id, as a new attribute in the EMPLOYEE table.
- In the EMPLOYEE table, Department_Id is the foreign key, and both the tables are related.

![image](https://static.javatpoint.com/dbms/images/dbms-keys6.png)


##### 5. Alternate key
There may be one or more attributes or a combination of attributes that uniquely identify each tuple in a relation. These attributes or combinations of the attributes are called the candidate keys. One key is chosen as the primary key from these candidate keys, and the remaining candidate key, if it exists, is termed the alternate key. In other words, the total number of the alternate keys is the total number of candidate keys minus the primary key. The alternate key may or may not exist. If there is only one candidate key in a relation, it does not have an alternate key.

**For example**, employee relation has two attributes, Employee_Id and PAN_No, that act as candidate keys. In this relation, Employee_Id is chosen as the primary key, so the other candidate key, PAN_No, acts as the Alternate key.

![image](https://static.javatpoint.com/dbms/images/dbms-keys7.png)




##### 6. Composite key
Whenever a primary key consists of more than one attribute, it is known as a composite key. This key is also known as Concatenated Key.

![image](https://static.javatpoint.com/dbms/images/dbms-keys8.png)

**For example**, in employee relations, we assume that an employee may be assigned multiple roles, and an employee may work on multiple projects simultaneously. So the primary key will be composed of all three attributes, namely Emp_ID, Emp_role, and Proj_ID in combination. So these attributes act as a composite key since the primary key comprises more than one attribute.

![image](https://static.javatpoint.com/dbms/images/dbms-keys9.png)



##### 7. Artificial key
The key created using arbitrarily assigned data are known as artificial keys. These keys are created when a primary key is large and complex and has no relationship with many other relations. The data values of the artificial keys are usually numbered in a serial order.

**For example**, the primary key, which is composed of Emp_ID, Emp_role, and Proj_ID, is large in employee relations. So it would be better to add a new virtual attribute to identify each tuple in the relation uniquely.


## Generalization
- Generalization is like a bottom-up approach in which two or more entities of lower level combine to form a higher level entity if they have some attributes in common.
- In generalization, an entity of a higher level can also combine with the entities of the lower level to form a further higher level entity.
- Generalization is more like subclass and superclass system, but the only difference is the approach. Generalization uses the bottom-up approach.
- In generalization, entities are combined to form a more generalized entity, i.e., subclasses are combined to make a superclass.

**For example**, Faculty and Student entities can be generalized and create a higher level entity Person.

![image](https://static.javatpoint.com/dbms/images/dbms-generalization.png)


## Aggregation
In aggregation, the relation between two entities is treated as a single entity. In aggregation, relationship with its corresponding entities is aggregated into a higher level entity.

**For example**: Center entity offers the Course entity act as a single entity in the relationship which is in a relationship with another entity visitor. In the real world, if a visitor visits a coaching center then he will never enquiry about the Course only or just about the Center instead he will ask the enquiry about both.

![image](https://static.javatpoint.com/dbms/images/dbms-aggregation.png)






## Reduction of ER diagram to Table
The database can be represented using the notations, and these notations can be reduced to a collection of tables.

In the database, every entity set or relationship set can be represented in tabular form.

**The ER diagram is given below:**


![image](https://static.javatpoint.com/dbms/images/dbms-reduction-of-er-diagram-into-table.png)


There are some points for converting the ER diagram to the table:

- **Entity type becomes a table.**

In the given ER diagram, LECTURE, STUDENT, SUBJECT and COURSE forms individual tables.

- **All single-valued attribute becomes a column for the table.**
In the STUDENT entity, STUDENT_NAME and STUDENT_ID form the column of STUDENT table. Similarly, COURSE_NAME and COURSE_ID form the column of COURSE table and so on.

- **A key attribute of the entity type represented by the primary key.**
In the given ER diagram, COURSE_ID, STUDENT_ID, SUBJECT_ID, and LECTURE_ID are the key attribute of the entity.

- **The multivalued attribute is represented by a separate table.**
In the student table, a hobby is a multivalued attribute. So it is not possible to represent multiple values in a single column of STUDENT table. Hence we create a table STUD_HOBBY with column name STUDENT_ID and HOBBY. Using both the column, we create a composite key.

- **Composite attribute represented by components.**
In the given ER diagram, student address is a composite attribute. It contains CITY, PIN, DOOR#, STREET, and STATE. In the STUDENT table, these attributes can merge as an individual column.

- **Derived attributes are not considered in the table.**
In the STUDENT table, Age is the derived attribute. It can be calculated at any point of time by calculating the difference between current date and Date of Birth.

Using these rules, you can convert the ER diagram to tables and columns and assign the mapping between the tables. Table structure for the given ER diagram is as below:


![image](https://static.javatpoint.com/dbms/images/dbms-reduction-of-er-diagram-into-table2.png)





## Relationship of higher degree
The degree of relationship can be defined as the number of occurrences in one entity that is associated with the number of occurrences in another entity.

There is the three degree of relationship:

1. One-to-one (1:1)
2. One-to-many (1:M)
3. Many-to-many (M:N)


#### 1. One-to-one
- In a one-to-one relationship, one occurrence of an entity relates to only one occurrence in another entity.
- A one-to-one relationship rarely exists in practice.
- **For example**: if an employee is allocated a company car then that car can only be driven by that employee.
- Therefore, employee and company car have a one-to-one relationship.

![image](https://static.javatpoint.com/dbms/images/dbms-relationship-of-higher-degree.png)


#### 2. One-to-many
- In a one-to-many relationship, one occurrence in an entity relates to many occurrences in another entity.
- **For example**: An employee works in one department, but a department has many employees.
- Therefore, department and employee have a one-to-many relationship.

![image](https://static.javatpoint.com/dbms/images/dbms-relationship-of-higher-degree2.png)


#### 3. Many-to-many
- In a many-to-many relationship, many occurrences in an entity relate to many occurrences in another entity.
- Same as a one-to-one relationship, the many-to-many relationship rarely exists in practice.
- **For example**: At the same time, an employee can work on several projects, and a project has a team of many employees.
- Therefore, employee and project have a many-to-many relationship.

![image](https://static.javatpoint.com/dbms/images/dbms-relationship-of-higher-degree3.png)



## Relational Model in DBMS
Relational model can represent as a table with columns and rows. Each row is known as a tuple. Each table of the column has a name or attribute.

**Domain**: It contains a set of atomic values that an attribute can take.

**Attribute**: It contains the name of a column in a particular table. Each attribute Ai must have a domain, dom(Ai)

**Relational instance**: In the relational database system, the relational instance is represented by a finite set of tuples. Relation instances do not have duplicate tuples.

**Relational schema**: A relational schema contains the name of the relation and name of all columns or attributes.

**Relational key**: In the relational key, each row has one or more attributes. It can identify the row in the relation uniquely.


**Example: STUDENT Relation**

![image](https://i.ibb.co/pdFgxwL/2024-06-28-015723.png)

- In the given table, NAME, ROLL_NO, PHONE_NO, ADDRESS, and AGE are the attributes.
- The instance of schema STUDENT has 5 tuples.
- t3 = <Laxman, 33289, 8583287182, Gurugram, 20>


#### Properties of Relations
- Name of the relation is distinct from all other relations.
- Each relation cell contains exactly one atomic (single) value
- Each attribute contains a distinct name
- Attribute domain has no significance
- tuple has no duplicate value
- Order of tuple can have a different sequence

