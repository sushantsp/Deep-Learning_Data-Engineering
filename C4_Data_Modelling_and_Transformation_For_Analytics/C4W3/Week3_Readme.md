## Learning Objectives
* Identify batch transformation use cases and patterns
* Compare an in-memory processing framework like Spark, and a processing framework that involves disk read and write operations, such as Hadoop
* Describe the technical considerations for choosing a distributed processing framework, such as Spark, vs a non-distributed framework like Pandas dataframes
* Describe the technical considerations for using SparkSQL vs DataFrames when transforming data using PySpark
* Explain how streaming transformation works with a near-real time processing engine such as Spark Structured Streaming


### Week Overview

![alt text](.images/Overview_1.png)
![alt text](.images/Overview_2.png)
![alt text](.images/Overview_3.png)

This weeks plan :

 focus on **data transformations** and the technical considerations for various data processing frameworks. 

- **Batch Transformation Use Cases**:  explored different scenarios where batch transformations are applicable as a data engineer.
  
- **Distributed Processing Frameworks**:
  - **Hadoop MapReduce**: Understand its use of disks for data storage and processing. Although considered a legacy technology, it's important to grasp the MapReduce paradigm as it influences modern distributed systems.
  - **Spark**: Learn about this in-memory processing framework, which is often preferred for its performance and scalability.

- **Transformation Logic**: You'll compare SQL-based transformations with those implemented in other languages, such as Python.

- **Lab Work**: You'll have the opportunity to perform transformations outside the data warehouse, similar to what you did with DBT earlier in the course.

- **Guest Speaker**: Navnit Shukla, a senior solutions architect at AWS, will discuss the AWS Glue Service, a tool built on Spark, and demonstrate how to generate Glue jobs for data processing.

- **Streaming Transformations**: In the second lesson, you'll implement a Change Data Capture (CDC) pipeline using Kafka and Flink to capture changes in your data source and update your system accordingly.

### Batch Transformation Patterns and Use Cases


Sure! Here’s a detailed summary of the lecture on batch processing and data transformation:

- **Batch Processing**: Data engineers often work with batch processing to serve data for analytics and machine learning. This involves manipulating discrete chunks of data on a fixed schedule (e.g., daily, hourly).

- **Transformation Approaches**:
  - **ETL (Extract, Transform, Load)**: Data is extracted, transformed using an external tool, and then loaded into a target system (e.g., data warehouse).
  - **ELT (Extract, Load, Transform)**: Raw data is extracted and loaded directly into a data warehouse, where it is then cleaned and transformed.
  - **EtLT (Extract, Transform, Load, Transform)**: A hybrid approach where simple transformations are applied before loading, followed by more complex transformations in the data warehouse.

- **Data Wrangling**: This process involves cleaning and normalizing data to handle issues like missing values and duplicates. While custom code can be used, data wrangling tools (e.g., AWS Glue DataBrew) are recommended for efficiency.

- **Data Updates**: 
  - **Truncate and Reload**: Deletes all records and reloads data from the source. Suitable for small datasets.
  - **Change Data Capture (CDC)**: Identifies changes in the source system and updates only those changes in the target system.
    ![alt text](<.images/Batch Transformation Pattern_2.png>)
- **Handling Updates**:
  - **Insert-Only Pattern**: New records are added without modifying old ones.
  - **Upsert/Merge Pattern**: Matches source records with target records to update or insert as necessary.

- **Delete Patterns**:
  - **Hard Delete**: Permanently removes records.
  - **Soft Delete**: Marks records as deleted without permanent removal.
    ![alt text](<.images/Batch Transformation Pattern_3.png>)
- **Inserting Data**: Single row inserts can be inefficient in OLAP systems. Instead, bulk loading is recommended for better organization and performance.
![alt text](<.images/Batch Transformation Pattern_4.png>)

- **Scalability**: As data transformations become more complex and datasets larger, distributed processing frameworks (like Spark) may be necessary.

This lecture emphasizes the importance of choosing the right transformation approach and tools based on the specific needs of the data and the architecture design.

### Distributed Processing Framework - Hadoop

- **Evolution of Big Data Tools**: The lecture discusses the development of big data tools to manage increasing data volumes, focusing on Apache Hadoop as a foundational framework.
![alt text](.images/Big_Data_1.png)

- **Limitations of Traditional Databases**: In the early 2000s, traditional databases could not efficiently handle massive data, leading to the need for scalable and reliable solutions.

- **Key Innovations**:
  - **Google File System (GFS)**: Introduced in 2003, it provided a fault-tolerant distributed file system.
  - **MapReduce**: A parallel programming model published by Google in 2004 for processing large datasets.
![alt text](.images/Big_Data_1.png)
- **Apache Hadoop**: Inspired by Google's innovations, Yahoo developed Hadoop in 2006, which includes:
  - **Hadoop Distributed File System (HDFS)**: A distributed file system that manages data across clusters.
  - **MapReduce**: Integrated into Hadoop for processing data.
**Hadoop Distributed File System (HDFS)**:
- **Purpose**: HDFS is designed to store large files across multiple machines in a distributed manner.
- **Architecture**:
  - **NameNode**: 
    - Acts as the master server.
    - Maintains the metadata for all files and directories in the file system.
    - Keeps track of where data blocks are stored across the cluster.
  - **DataNodes**: 
    - These are the worker nodes that store the actual data blocks.
    - Each DataNode manages the storage of its blocks and periodically sends heartbeat signals to the NameNode to confirm its status.
- **Data Replication**:
  - Each data block is typically replicated across three DataNodes.
  - This replication ensures data durability and availability. If one DataNode fails, the data can still be accessed from another node.
![alt text](.images/HDFS_1.png)
**Data Block Management**:
- **Block Size**: 
  - HDFS breaks files into blocks, usually 128 MB or 256 MB in size.
  - This large block size reduces the overhead of managing many small files and optimizes data processing.
- **Fault Tolerance**:
  - If a DataNode fails, the NameNode detects the failure and re-replicates the blocks that were stored on that node to maintain the desired replication factor.
![alt text](.images/HDFS_2.png)


**MapReduce Programming Model**:
- **Map Phase**:
  - Each block of data is processed by a separate map task.
  - The map function reads the data and produces intermediate key-value pairs.
- **Shuffle Phase**:
  - After mapping, the framework redistributes the key-value pairs based on keys.
  - This ensures that all values associated with the same key are sent to the same reducer.
  ![alt text](.images/HDFS_3.png)
- **Reduce Phase**:
  - The reduce function aggregates the intermediate results for each key.
  - The final output is written back to HDFS.

**Data Locality**:
- Hadoop emphasizes data locality, meaning that computation is performed close to where the data is stored.
- This reduces network traffic and increases processing speed, as data does not need to be moved across the network to be processed.
![alt text](.images/HDFS_4.png)
- **Example**: Running a SQL query to count records by user ID demonstrates how MapReduce processes data efficiently by working on smaller blocks rather than the entire dataset.

- **Shortcomings of MapReduce**: 
  - High disk usage and processing time due to reading and writing data to disk.
  - No intermediate state is preserved in memory.
![alt text](.images/HDFS_Shortcomings.png)
- **Advancements**: New frameworks like Apache Spark have emerged, allowing for in-memory processing, which significantly speeds up data processing tasks.

- **Conclusion**: While Hadoop and MapReduce are not the latest technologies, understanding their concepts is crucial as they influence many current data processing systems.







