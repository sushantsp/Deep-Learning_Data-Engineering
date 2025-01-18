* _Setting up an RDS in your account_

in most labs so far, you were given an instance of an Amazon RDS MySQL table to use. However, you can create your own RDS database instance in your personal account through the AWS management console as explained [here](https://aws.amazon.com/getting-started/hands-on/create-mysql-db/)
. In the upcoming weeks, you will learn how to create an RDS database programmatically using Terraform. 

* _How to connect to an RDS instance?_

After you create your own public instance of an Amazon RDS database, you need to establish a connection to the database server to query it.  In this example, the Amazon RDS database we are connecting to is MySQL, and the following information is needed:

* Database hostname/endpoint (address or location of the database server)

* Database port (the network port the MySQL server is running on)

* Database username & password (credentials to log in to the database)

You can get the hostname/endpoint and port from the AWS management console or programmatically from the command line interface (CLI) after you create the table. You would have created the database username & password when setting up the database instance. Otherwise, ask the database administrator for this information.

Connecting to the database through AWS CloudShell

To connect to MySQL database through the console, you can use the following command (
link to documentation
)

```
mysql --host=[hostname] 

 --port=[port number] 

 --user=[database user name]

 --password=[database user password]
```

The endpoint and port number were manually entered, but you could get them programmatically using this 
describe-db-instances
 command:

 ```
 aws rds describe-db-instances --filters "Name=engine,Values=mysql" --query "*[].[DBInstanceIdentifier,Endpoint.Address,Endpoint.Port,MasterUsername]"
 ```


 ![alt text](<.images/connecting to database_1.png>)

 ![alt text](<.images/connecting to database_2.png>)


 To exit the connection, you can type exit or \q. (Note: to create your own tables, check lab 1 of this week or the 
MySQL documentation
).