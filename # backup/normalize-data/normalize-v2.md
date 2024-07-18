# Normalization
A large database defined as a single relation may result in data duplication. This repetition of data may result in:

- Making relations very large.
- It isn't easy to maintain and update data as it would involve searching many records in relation.
- Wastage and poor utilization of disk space and resources.
- The likelihood of errors and inconsistencies increases.


So to handle these problems, we should analyze and decompose the relations with redundant data into smaller, simpler, and well-structured relations that are satisfy desirable properties. Normalization is a process of decomposing the relations into relations with fewer attributes.

### What is Normalization?
- Normalization is the process of organizing the data in the database.
- Normalization is used to minimize the redundancy from a relation or set of relations. It is also used to eliminate undesirable characteristics like Insertion, Update, and Deletion Anomalies.
- Normalization divides the larger table into smaller and links them using relationships.
- The normal form is used to reduce redundancy from the database table.


### Why do we need Normalization?

The main reason for normalizing the relations is removing these anomalies. Failure to eliminate anomalies leads to data redundancy and can cause data integrity and other problems as the database grows. Normalization consists of a series of guidelines that helps to guide you in creating a good database structure.


Data modification anomalies can be categorized into three types:

- **Insertion Anomaly**: Insertion Anomaly refers to when one cannot insert a new tuple into a relationship due to lack of data.
- **Deletion Anomaly**: The delete anomaly refers to the situation where the deletion of data results in the unintended loss of some other important data.
- **Updatation Anomaly**: The update anomaly is when an update of a single data value requires multiple rows of data to be updated.



### Types of Normal Forms:
Normalization works through a series of stages called Normal forms. The normal forms apply to individual relations. The relation is said to be in particular normal form if it satisfies constraints.

Following are the various types of Normal forms:

![image](https://i.ibb.co/1J9ttXq/dbms-normalization.png)

|Normal Form|Description    |
|---        |---            |
|1NF        |A relation is in 1NF if it contains an atomic value.|
|2NF        |A relation will be in 2NF if it is in 1NF and all non-key attributes are fully functional dependent on the primary key. |
|3NF        |	A relation will be in 3NF if it is in 2NF and no transition dependency exists. |
|BCNF       |	A stronger definition of 3NF is known as Boyce Codd's normal form. |
|4NF        |	A relation will be in 4NF if it is in Boyce Codd's normal form and has no multi-valued dependency. |
|5NF        |	A relation is in 5NF. If it is in 4NF and does not contain any join dependency, joining should be lossless. |



#### Advantages of Normalization
- Normalization helps to minimize data redundancy.
- Greater overall database organization.
- Data consistency within the database.
- Much more flexible database design.
- Enforces the concept of relational integrity.



#### Disadvantages of Normalization
- You cannot start building the database before knowing what the user needs.
- The performance degrades when normalizing the relations to higher normal forms, i.e., 4NF, 5NF.
- It is very time-consuming and difficult to normalize relations of a higher degree.
- Careless decomposition may lead to a bad database design, leading to serious problems.


## First Normal Form (1NF)
- A relation will be 1NF if it contains an atomic value.
- It states that an attribute of a table cannot hold multiple values. It must hold only single-valued attribute.
- First normal form disallows the multi-valued attribute, composite attribute, and their combinations.

**Example**: Relation EMPLOYEE is not in 1NF because of multi-valued attribute EMP_PHONE.

**EMPLOYEE table:**

![image](https://i.ibb.co/hRrJd47/1.png)

The decomposition of the EMPLOYEE table into 1NF has been shown below:

![image](https://i.ibb.co/qsxYfkq/2.png)


## Second Normal Form (2NF)
- In the 2NF, relational must be in 1NF.
- In the second normal form, all non-key attributes are fully functional dependent on the primary key


**Example**: Let's assume, a school can store the data of teachers and the subjects they teach. In a school, a teacher can teach more than one subject.

**TEACHER table:**

![image](https://i.ibb.co/WGW7S3p/3.png)

In the given table, non-prime attribute TEACHER_AGE is dependent on TEACHER_ID which is a proper subset of a candidate key. That's why it violates the rule for 2NF.

To convert the given table into 2NF, we decompose it into two tables:

**TEACHER_DETAIL table:**

![image](https://i.ibb.co/KGSyFRj/4.png)

**TEACHER_SUBJECT table:**

![image](https://i.ibb.co/nMbJktS/5.png)


## Third Normal Form (3NF)
- A relation will be in 3NF if it is in 2NF and not contain any transitive partial dependency.
- 3NF is used to reduce the data duplication. It is also used to achieve the data integrity.
- If there is no transitive dependency for non-prime attributes, then the relation must be in third normal form.

A relation is in third normal form if it holds atleast one of the following conditions for every non-trivial function dependency X → Y.

1. X is a super key.
2. Y is a prime attribute, i.e., each element of Y is part of some candidate key.

**Example:**

**EMPLOYEE_DETAIL table:**

![image](https://i.ibb.co/TPkCVb8/6.png)

**Super key in the table above:**

```sql
{EMP_ID}, {EMP_ID, EMP_NAME}, {EMP_ID, EMP_NAME, EMP_ZIP}....so on  
```


**Candidate key:** {EMP_ID}

**Non-prime attributes:** In the given table, all attributes except EMP_ID are non-prime.

Here, EMP_STATE & EMP_CITY dependent on EMP_ZIP and EMP_ZIP dependent on EMP_ID. The non-prime attributes (EMP_STATE, EMP_CITY) transitively dependent on super key(EMP_ID). It violates the rule of third normal form.

That's why we need to move the EMP_CITY and EMP_STATE to the new <EMPLOYEE_ZIP> table, with EMP_ZIP as a Primary key.


**EMPLOYEE table:**

![image](https://i.ibb.co/FY6fGTK/7.png)


**EMPLOYEE_ZIP table:**

![image](https://i.ibb.co/qpTbck0/8.png)







## Boyce Codd normal form (BCNF)
- BCNF is the advance version of 3NF. It is stricter than 3NF.
- A table is in BCNF if every functional dependency X → Y, X is the super key of the table.
- For BCNF, the table should be in 3NF, and for every FD, LHS is super key.


**Example**: Let's assume there is a company where employees work in more than one department.

**EMPLOYEE table:**

![image](https://i.ibb.co/tXqwzpJ/9.png)

In the above table Functional dependencies are as follows:

```sql
EMP_ID  →  EMP_COUNTRY  
EMP_DEPT  →   {DEPT_TYPE, EMP_DEPT_NO}  
```

__Candidate key: {EMP-ID, EMP-DEPT}__

The table is not in BCNF because neither EMP_DEPT nor EMP_ID alone are keys.

To convert the given table into BCNF, we decompose it into three tables:

**EMP_COUNTRY table:**

![image](https://i.ibb.co/7kxnny2/10.png)


**EMP_DEPT table:**

![image](https://i.ibb.co/4NPDLHp/11.png)

**EMP_DEPT_MAPPING table:**

![image](https://i.ibb.co/k4tm1Zj/12.png)


**Functional dependencies:**

```sql
EMP_ID   →    EMP_COUNTRY  
EMP_DEPT   →   {DEPT_TYPE, EMP_DEPT_NO}  
```

**Candidate keys:**

**For the first table**: EMP_ID
**For the second table**: EMP_DEPT
**For the third table**: {EMP_ID, EMP_DEPT}

Now, this is in BCNF because left side part of both the functional dependencies is a key.





## Fourth normal form (4NF)
- A relation will be in 4NF if it is in Boyce Codd normal form and has no multi-valued dependency.
- For a dependency A → B, if for a single value of A, multiple values of B exists, then the relation will be a multi-valued dependency.


**Example
STUDENT**

![image](https://i.ibb.co/CsKFQ35/13.png)

The given STUDENT table is in 3NF, but the COURSE and HOBBY are two independent entity. Hence, there is no relationship between COURSE and HOBBY.

In the STUDENT relation, a student with STU_ID, 21 contains two courses, **Computer** and **Math** and two hobbies, **Dancing** and **Singing**. So there is a Multi-valued dependency on STU_ID, which leads to unnecessary repetition of data.

So to make the above table into 4NF, we can decompose it into two tables:

**STUDENT_COURSE**

![image](https://i.ibb.co/L5Q4T1H/14.png)

**STUDENT_HOBBY**

![image](https://i.ibb.co/9VfpbQx/15.png)




## Fifth normal form (5NF)
- A relation is in 5NF if it is in 4NF and not contains any join dependency and joining should be lossless.
- 5NF is satisfied when all the tables are broken into as many tables as possible in order to avoid redundancy.
- 5NF is also known as Project-join normal form (PJ/NF).


**Example**

![image](https://i.ibb.co/DQ35fDy/16.png)

In the above table, John takes both Computer and Math class for Semester 1 but he doesn't take Math class for Semester 2. In this case, combination of all these fields required to identify a valid data.

Suppose we add a new Semester as Semester 3 but do not know about the subject and who will be taking that subject so we leave Lecturer and Subject as NULL. But all three columns together acts as a primary key, so we can't leave other two columns blank.

So to make the above table into 5NF, we can decompose it into three relations P1, P2 & P3:

**P1**

![image](https://i.ibb.co/G3v9ZRr/17.png)

**P2**

![image](https://i.ibb.co/dKcQVbR/18.png)

**P3**

![image](https://i.ibb.co/3RcTkpB/19.png)


## Relational Decomposition
- When a relation in the relational model is not in appropriate normal form then the decomposition of a relation is required.
- In a database, it breaks the table into multiple tables.
- If the relation has no proper decomposition, then it may lead to problems like loss of information.
- Decomposition is used to eliminate some of the problems of bad design like anomalies, inconsistencies, and redundancy.

#### Types of Decomposition

![image](https://i.ibb.co/QQxmd9j/dbms-relational-decomposition.png)


#### Lossless Decomposition
- If the information is not lost from the relation that is decomposed, then the decomposition will be lossless.
- The lossless decomposition guarantees that the join of relations will result in the same relation as it was decomposed.
- The relation is said to be lossless decomposition if natural joins of all the decomposition give the original relation.


**Example:**

**EMPLOYEE_DEPARTMENT table:**

![image](https://i.ibb.co/s3ZkGj1/21.png)

The above relation is decomposed into two relations EMPLOYEE and DEPARTMENT

**EMPLOYEE table:**

![image](https://i.ibb.co/TMg0T1Q/22.png)

**DEPARTMENT table**

![image](https://i.ibb.co/n3knWF5/23.png)

Now, when these two relations are joined on the common column "EMP_ID", then the resultant relation will look like:

**Employee ⋈ Department**

![image](https://i.ibb.co/Xky0nLR/24.png)


Hence, the decomposition is Lossless join decomposition.

#### Dependency Preserving

- It is an important constraint of the database.
- In the dependency preservation, at least one decomposed table must satisfy every dependency.
- If a relation R is decomposed into relation R1 and R2, then the dependencies of R either must be a part of R1 or R2 or must be derivable from the combination of functional dependencies of R1 and R2.
- For example, suppose there is a relation R (A, B, C, D) with functional dependency set (A->BC). The relational R is decomposed into R1(ABC) and R2(AD) which is dependency preserving because FD A->BC is a part of relation R1(ABC).








