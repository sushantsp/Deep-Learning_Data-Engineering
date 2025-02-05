## Storage Deep Dives

**Learning Objectives**
* Explain how data is physically stored on disk and in memory
* Compare how data is stored and queried in object, block, and file storage systems
* Explain how data is stored in row-oriented vs column-oriented databases
* Explain how graph and vector databases store and retrieve data

### Data Storage Deep Dive

**Overview of the content**

![alt text](.images/Content_1.png)

Week 2 will talk about how to choose storage abstractions for the usecase. 
Week 3 talks about 
* How Queries work
* How different storage solutions 
affect query performance 
* Techniques for improving query 
performance


**Physical Components of Data Storage**

![alt text](.images/Storage_basics_1.png)

![alt text](.images/Storage_basics_2.png)

**Processes required for Data Storage**

* Serialization

Data structure when required for memory is often complex and is optmised for quick access and manipulation.
But when comes to storing it on disk storage, it requires simpler and standardised format. This serialization takes care tranforming data. Deserlzation is done again memory manipulation. Digram below shows it. 

![alt text](.images/Storage_basics_3_serialization.png)

Here are the serialization formats that are generally used in the industry.

![alt text](.images/Storage_basics_4_serialization.png)

Decisions you take as data engineer on serilization format can severy impact your query performance. In a good and bad way. 
Eg. Just by moving from csv to parquet - team could enhance the performance of their data system by a factor of 100. 

* Compression

Once the data volume grows even after serlization, it can slow the movement of data on network. There comes the idea of compression. COmpressing the data to transport it fast and efficient manner over the network. Here is digram depiciting it. 

![alt text](.images/Storage_basics_5_compression.png)

**CLoud Storage Options**