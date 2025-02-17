**Learning Objectives**
* Define data modeling and its role in reflecting business logic
* Apply the normalization stages to a denormalized table
* Explain the use of the fact and dimension tables of a star schema
* Differentiate between the data warehouse modeling approaches such as Inmon, Kimball and Data Vault
* Transform data in third normal form to a star schema
* Describe the use of hub, link and satellite tables in a data vault model
* Discuss the pros and cons of the use of one big table


## Introduction to Data Modelling for Analytics

### Course Overview :


Data modeling involves deliberately choosing a coherent data structure that aligns with business goals and logic, defining the structure, relationships, and meaning of the data.

![alt text](.images/Data_Model_1.png)

what makes something a good data model ?

![alt text](.images/Data_Model_2.png)

Examples :
 
1. **Good Data Model**: 
   - Linking **sales data** with **product inventory data** to ensure that the sales process is directly informed by current inventory levels, which helps prevent overselling.

2. **Bad Data Model**: 
   - A poorly constructed model that is created haphazardly and does not reflect how the business operates, leading to inaccurate information and confusion among stakeholders.

Sometimes data teams ignore data modeling entirely because they perceive it as a slow, tedious, and irrelevant process, often jumping directly into building data systems without a structured plan for organizing the data. This oversight can lead to the creation of data swamps, resulting in redundant, mismatched, or inaccurate data. _Data Modelling is a critical practice that enhances your understanding of the data throughout its life cycle._


Targeted Data Modelling : It aims to help particular teams, such as marketing or finance, better understand their data and improve decision-making.

![alt text](.images/Data_Model_3.png)

- **Examples**:
  - Creating a data model for the **marketing team** to analyze customer behavior and campaign effectiveness.
  - Modeling **financial transactions** for the finance team to identify spending patterns and cost-saving opportunities.
  - Targeted data modeling efforts can drive better decision-making and support impactful AI models, even in complex business environments.


### Conceptual Logical and Physical Data Modelling

### Normalization

![alt text](.images/Normalized_data_1.png)

It is a data modeling practice applied to relational databases to reduce data redundancy and ensure referential integrity between data tables.
- Introduced by **Edgar Codd** in 1970, normalization aims to improve data integrity and reduce undesirable dependencies.

Codd outlined several objectives for normalization:
- **Eliminate Insertion, Update, and Deletion Dependencies**: This helps prevent anomalies when adding, modifying, or deleting data.
- **Reduce Restructuring Needs**: As new types of data are introduced, normalization minimizes the need to restructure the database.
- **Increase Application Lifespan**: By maintaining data integrity, applications can remain functional for longer periods.

Two models are presented to illustrate normalization:
1. **Less Normalized Model**: 
   - Consists of a single large sales order table.
   - Contains redundant data, making updates cumbersome (e.g., updating a customer's address requires changing multiple rows).
   
2. **More Normalized Model**: 
   - Data is spread across multiple tables (e.g., separate tables for customers, orders, and shipments).
   - Reduces redundancy; updating a customer's address only requires changing one row in the customer table.

Denormalized Form :

![alt text](.images/Normalized_data_2.png)

various normalization forms:
- **First Normal Form (1NF)**: 
  - Requires each column to have unique values and no nested data.
  - A unique primary key must be present.

  ![alt text](.images/Normalized_data_3.png)  

- **Second Normal Form (2NF)**: 
  - Builds on 1NF by removing partial dependencies, where non-key columns depend on part of a composite key.
  - Example: Splitting a sales order table into separate order items and orders tables.

  ![alt text](.images/Normalized_data_4.png)

- **Third Normal Form (3NF)**: 
  - Requires compliance with 2NF and eliminates transitive dependencies, where non-key columns depend on other non-key columns.
  - Example: Creating separate tables for items and customers to remove dependencies.

### Denormalization
- **Denormalization** may be beneficial in certain scenarios, as it can enhance performance by reducing the need for join operations between tables.
- The choice between normalization and denormalization depends on the specific use case and performance requirements.


practiceLab Data Normalization

### Dimensional Modelling - Star Schema

![alt text](.images/Star_Schema_1.png)

- **Star Schema**: 
  - A **dimensional data model** designed to facilitate faster analytical queries.
  - It consists of a **fact table** at the center, surrounded by **dimension tables**.
  - The fact table contains **quantitative business measurements** (facts) from business events, while dimension tables provide **contextual information**.

- **Fact Table**:
  - Contains **business measures** resulting from events (e.g., trip duration, trip price in a rideshare example).
  - Each row corresponds to a specific event, and the data is **immutable** (append-only).
  - Typically **narrow and long** (few columns, many rows).

- **Dimension Tables**:
  - Provide descriptive attributes related to the facts (e.g., information about customers, drivers, trip locations).
  - Typically **wide and short** (many columns, fewer rows).

- **Grain**:
  - Refers to the level of detail in the fact table (e.g., each row could represent a single ride or all rides in a day).
  - The **atomic grain** is the most detailed level, capturing individual events.

- **Keys**:
  - Fact tables connect to dimension tables through **foreign keys**.
  - Each dimension has a **primary key**, and best practices suggest using a **surrogate key** for the fact table.

  ![alt text](.images/Star_Schema_2.png)

- **Analytical Queries**:
  - Star schema simplifies queries, allowing for easier aggregation and filtering.
  - Example SQL query: To find total sales for each product line in the USA, you would join the fact table with dimension tables and apply aggregate functions.

- **Comparison with Normalized Models**:
  - Normalized models focus on reducing data redundancy and ensuring data integrity.
  - Star schemas are more user-friendly for analytical workloads, resulting in simpler queries and improved performance.

  **Example**
  ![alt text](.images/Star_Schema_3.png)