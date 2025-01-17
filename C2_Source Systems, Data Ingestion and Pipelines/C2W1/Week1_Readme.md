## Week1 - Introduction to source systems

![image](./.images/Week_details.png)

### _Different Types of source systems_
* Types of data
1. Structured Data
2. Semistructured Data
    - JSON
    - Not in tabular but still has some structure.


Data Bases -

1. Relational Databases
2. Non Relational Databases. NoSQL

Files - 

1. Comman source systems for data ingestion.

Streaming Systems - 

1. Semi- Structured data
2. Continuous flow of data



|Databases|Files   |Streaming Systems|
|----|--------   |--------|
|![alt text](<.images/Types of Source systems_1.png>)| ![alt text](<.images/Types of Source systems_2.png>)   |![alt text](<.images/Types of Source systems_3.png>)


![image](.images/In_summary_source_systems.png)

### _Relational Databases_

Normalised Relatetional databases provides high degree of integrity and reduced redundancy. But it can actually be slow to querying the data. 
Utlimately how you are storing the data depends on what are you trying to optimise for. 

OBT - One big table approach for everything for faster processing. 

![alt text](.images/relational_databases.png)


Querying the data can be distributed into 4 stages:
1. Data Cleaning
2. Data Joining
3. Data Aggregating
4. Data Filtering

![alt text](.images/relational_databases_2.png) 

While dealing with relational databases you need to know :
1. What are the tables ?
2. How are they connected ?
3. What are the columns ?




This can be understood by looking at the entity relationship diagram. Then you can start querying the data.

Ex. Entity Relationship Diagram showing primary keys and foreign keys

![Entity Relationship Diagram](.images/relational_databases_3.png) 

Types of joins. By default, ON is used for INNER JOIN
![Join Types](.images/relational_databases_4.png) 

You can use other aggregated functions such as COUNT after `SELECT` and create a column for it. Need to use GROUP BY for the same. 
![Aggregation Example](.images/relational_databases_5.png)


### SQL LAB

* Before you start issuing SQL queries to the database, you need first to establish a connection to the MYSQL database. For that, you need information such as the database username, password, hostname (or address), port number and the database name.

**##** 3 - Create, Read, Update, and Delete (CRUD) Operations

CRUD stands for Create, Read, Update, and Delete, which are basic operations for manipulating data. When we talk about databases, we use `INSERT INTO`, `SELECT`, `UPDATE`, and `DELETE` statements respectively to refer to CRUD operations.

Refer SQL Practice notebook for more info.

### _NoSQL Databases_

No SQL databases were developed to overcome the limitations of relational databases. 
![image](./.images/NoSQL%20Databases.png)

* NoSQL databases have horizontal scaling - can also be called as eventual scaling.
Meaning the data doesnt get updated to all the nodes - it happens eventually. This has adventage in speed and time. particularly useful for social media and not live streaming apps. 

![image](./.images/NoSQL%20Consistency.png)

NoSQL databases have special query language

```json
{ 
  "id": 1,  
  "key": "Blender",  
  "qty": 6, 
  "sku": “b32" 
}
```
Query

`db.products.find({qty: {$gt: 4}})`

Types of NoSQL Databases :
 | Key-Value Pair Databases                          | Document Databases                          |
 |--------------------------------------------------|---------------------------------------------|
 | ![alt text](.images/key_value_databases..png)     | ![alt text](.images/document_databases.png) |
 | * Fast lookup - like user cache to store session & Flexible schema | Fixed schema                               |
 | No Join Support                                   | Support different Joins                     |
 | Use Cases - Content Management, user catalogs, sensor readings | Used long term data that has schema         |


* ACID Compliant databases

![alt text](.images/ACID_Compliance.png)

Follwoed by the lab  on Amazon DynamoDB


![alt text](<.images/DynamoDB NoSQL.png>) 
![alt text](<.images/DynamoDB NoSQL_2.png>)
![alt text](<.images/DynamoDB NoSQL_3.png>) 

Data for the lab


![alt text](<.images/DynamoDB NoSQL_4.png>)

lab uses boto3 which is amazon's SDK for python. - allows you to interact with python resources.

boto3 create client objects. allows you to make api requiest directly. 


**How will you create the tables?**

You will use the [DyanmoDB create_table()](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb/client/create_table.html) method. This method expects 3 required parameters:
* `TableName`: the name of the table.
* `KeySchema`: an array of the attributes that make up the primary key for a table. For each element in this array, you need to specify: `AttributeName`: the name of the attribute, and `KeyType`: the role that the key attribute will assume (`HASH` if it is a partition key and `RANGE` if it is a sort key). For example,
  ```
  'KeySchema'= [
      {'AttributeName': 'ForumName', 'KeyType': 'HASH'}, 
      {'AttributeName': 'Subject', 'KeyType': 'RANGE'}
  ]
  ```
* `AttributeDefinitions`: an array that describes the attributes that make up the primary key. For each element in this array, you need to specify `AttributeName` and `AttributeType`: the data type for the attribute (S: String, N: Number, B: Binary,...). For example, 
  ```
  'AttributeDefinitions': [
      {'AttributeName': 'ForumName', 'AttributeType': 'S'},
      {'AttributeName': 'Subject', 'AttributeType': 'S'}
  ]
  ```
There is an additional parameter that you can specify if you don't wish to pay for DynamoDB based on demand and you want to choose the provisioned mode:
* `ProvisionedThroughput`: a dictionary that specifies the read/write capacity (or throughput) for a specified table. It consists of two items:
  - `ReadCapacityUnits`: the maximum number of strongly consistent reads consumed per second;
  - `WriteCapacityUnits`: the maximum number of writes consumed per second. 
* Object Storages

Generally there is no hierarchy in the object storage. all the things are stored at the top level.
S3 provides the feature to see them in folder structure but they are all at teh top level. 

### Object storage

Generally doesnt offer file hierarchical system like a tradtional folder structure.

Object storage offers a uuid. Universal Unique Identifier. you can have multiple version of the same object pointing toward same uuid. This versioning will be part of metadata.

* stores semi-structure and structured data
* used for storing machine learning objects - serving data for machine learning models. 

![alt text](.images/Object_storage_1.png)

* WHy use object storage ?

1.  Store files of various data formats without a specific file system structure
2.  Easily scales to massive size.
3.  Replicate data across several availability zones
4.  Cheaper than other storage options

- A bucket is a container for objects stored in Amazon S3.
- An object is a file and any metadata that describes that file. It has a unique identifier, also known as the object key. Object storage allows the storage of any object; you can store not only structured but also unstructured and semi-structured data.


### Logs and Streaming systems

* Logs are more like a exhause of a system. It includes metadata about data creation. 
* They are a rich source of information just more than monitoring a health of a system.

 ![alt text](.images/Logs_1.png)

 Those changes in database can be used to trigger the ingestion process. 
 - Can be used for anamoly detection.
 - It can be used for automation too. 
 
 ![alt text](.images/Logs_2.png)