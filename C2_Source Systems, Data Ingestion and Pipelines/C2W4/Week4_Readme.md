Learn all about orchestrating your data pipeline tasks. You'll identify the various orchestration tools, but will focus on Airflow -- one of the most popular and widely used tools in the field today. You'll explore the core components of Airflow, the Airflow UI, and how to create and manage DAGs using various Airflow features.

## Learning Objective 
* Explain how orchestration can be applied to a data pipeline and list its benefits
* List and interact with the core components of Airflow
* Build data pipelines with DAGs in Airflow using features such as Taskflow API, operators, XCom, variables, etc.
* Apply the best practices in building DAGs in Airflow
* Integrate data quality testing using Great Expectations in an orchestrated pipeline in Airflow


### Before Orchestration

Use of Cron in earlier days was for simple tasks. It was basically pure scheduling. Modern day complex data pipelines will be difficult with cron. Hence the development of orchetration tools.

* How CRON works ?
![alt text](.images/CRON_1.png)

Example of Modern pipeline using CRON - has lot of issues with it.
![alt text](.images/CRON_2.png)

When to use CRON ?

* To schedule simple and repetitive tasks.
* In the prototype phase.


### Evolution of orchestration Tools

MOst widely used orchestration tool now days is AirFlow, developed by airbnb for their needs internally. 

![alt text](.images/AirFlow_1.png)

Other orchestration tools are PREFECT, dagster and MAGE.


### Orchestration Basics

With orchestration there are a few cons as well, mainly being More operational overhead than simple con scheduling. BUt with pros it makes more sense to use these orchestration tools. THese are :
* Set up dependencies. - start the other when earlier ends. 
* Monitor alerts
* Get alterts
* Create fallback plans.

**Directed Acyclic Graph (DAG)** - Orchestration tools create somethings known as DAG. Data only flows in one direction and there are no cycles in the pipeline. Hence Directed Acyclics. It is called Graph because every step in the pipeline can be considered as node and edge being the direction of flow of data from on step to other. This sort of visual representation is known as _Directed Acyclic Graph_. 


![alt text](.images/Orchestration_1_DAG.png)

**How is this done in airflow** : (what services airflow offeres.)

![alt text](.images/Orchestration_2_Tasks&Dependencies.png) 

Triggers to run the DAG - 
1. Trigger based on the Schedule
2. Trigger based on an event - Eg. When dataset is updated.
3. Trigger a portion of the DAG based on an event

![alt text](.images/Orchestration_3.png)



We can have data quality checks in the live pipeline with the orchestration flow. Such as follow

![alt text](.images/Orchestration_4.png)

### Airflow - Core Components

Ofall the compoenents of the Airflow, User only interacts with `DAG Directory` and `User Interface` also called as UI. UI is used for moniotring the DAG workflows when they start. 

Certainly! Here's a summary focusing on the key components of Apache Airflow and their functions:

---

The video introduces Apache Airflow, emphasizing its architecture and how its components work together to manage and execute Directed Acyclic Graphs (DAGs). The main components of Airflow include:

1. **DAG Directory**: A folder where Python scripts defining DAGs are stored. Adding a DAG here automatically makes it visible in the Airflow User Interface (UI).

2. **Web Server**: Hosts the Airflow UI, allowing users to visualize, monitor, trigger, and troubleshoot DAGs and their tasks.

3. **Scheduler**: Monitors DAGs in the DAG directory, checking every minute to determine if any tasks should be triggered based on schedules or dependencies. It queues tasks ready for execution.

4. **Executor**: Part of the scheduler, it manages task execution by sending tasks from the queue to workers.

5. **Workers**: Execute the tasks. The status of tasks transitions from scheduled to queued, then running, and finally to success or failure.

6. **Metadata Database**: Stores the state and status of DAGs and tasks. The web server retrieves this data to display in the UI.

For those using managed Airflow services like `Amazon Managed Workflows for Apache Airflow (MWAA)`, these components are automatically set up in the cloud. For instance, `Amazon MWAA` uses an S3 bucket as the DAG directory and Aurora PostgreSQL as the metadata database, with additional AWS services for security and monitoring.

Here is the schematic showing the Airflow Components :

![alt text](.images/Airflow_components_1.png) 
![alt text](.images/Airflow_components_2.png) 
![alt text](.images/Airflow_components_3.png)

Here is Amazon managed workflow for Apache workflow
![alt text](.images/Airflow_components_4.png)


### Creating a DAG

Joe walks through the proess of creation of DAG using workflow in python. Here is one script for creationg simple ETL DAG throgh python :

![alt text](.images/Creating_DAG_1.png)

Bit shift operator tells you that `Task2` starts after the ``Task1`` has completed. vice versa for `Task3` and `Task2`.

There are different types of operator in airflow. Such as :
1. `PythonOperator` - Executes a python script
2. `BashOperator` - Executes Bash commands
3. `EmptyOperator` - Helps in organising the DAG
4. `EmailOperator` - For Notification via email
5. `Sensor` - Special type of operator for making the DAG event driven 


These operators are python classes to encapusalte the logic. You can import them into your code.

Other ways to create DAG Dependencies :

![alt text](.images/Creating_DAG_2.png)

### Practice Lab 1 - Buildng a data pipeline using AIrflow


### Airflow - Xcom and Variable

- to learn how to pass data from one task to next. And about global variables.
- We use intermediate storage like S3 for large datasets. But for small data like metadata, dates, single value variables we use xcom

**Xcom** is a short for cross communication. Is used for sharing data betwen tasks. 
Data is stored in metadata database. `xcom_push` pushes the data in database and `xcom_pull` pulls the data in next task where it is required. Both are based on context dictiornay that is associated with DAG.

![alt text](.images/Xcom_DAG_1.png)

![alt text](.images/Xcom_DAG_2.png)

You can check your xcoms in your UI. for accessing you can check them under `Admin > Xcoms`.

_Caution_: They are not designed for passing large datasets. They will degrade the performance of the DAG and database. 
**User-Created Variables**

Instead of hardcoding the value of the variables :

* Create variable in airflow UI
* Create Environment variables

![alt text](.images/Xcom_DAG_3.png)

**Best Practices**

1. Avoid high level code
2. Keep Tasks simple and atomic
3. Use Variables, user-Created Variables in AirFlow UI
4. Create task groups if possibe :
   In the Airflow UI, you can group tasks using Task Groups to organize your DAGs and make them more readable. Inside the task group, you can define tasks and their dependencies using the bit-shift operators <<  and  >>.  You can create a Task Group using the  "with" statement, as shown in the following example.
5. Other Practices :
   * Airflow is an Orchestrator not an executer. Heave tasks should be assumed by executor like spark.
   * Including code that is not part of your DAG or operator makes your DAG hard to maintain and read: consider keeping any extra code that is needed for your tasks in a separate file.
   * 

### TaskFlow API

Its a feature in Apache Airflow 2.0 that uses decorators to create DAG's and tasks associated with DAG making it simpler by creating consise and clean code. 

* `@dag` & `@task` are the decorators that are used in the creating DAG and task. You define the dag parameters direcly in decorator & create a python function
* We use return function to share the data between the tasks instead of `xcom_push` and `xcom_pull.`
* Function names become `dag_id` and `task_id`.
![alt text](.images/TaskFlow_API_1.png)

![alt text](.images/TaskFlow_API_2.png)
* Here is an example of DAG and task creation:
```python

from airflow.decorators import dag, task
from airflow.utils.dates import days_ago

# Define the DAG using the @dag decorator
@dag(schedule_interval='@daily', start_date=days_ago(1), catchup=False, tags=['example'])
def example_dag():
    
    # Define the first task using the @task decorator
    @task
    def extract_data():
        print("Extracting data...")
        return {"data": "Sample data"}

    # Define the second task using the @task decorator
    @task
    def process_data(data):
        print(f"Processing data: {data['data']}")
        
    # Define task dependencies
    data = extract_data()
    process_data(data)

# Instantiate the DAG
dag_instance = example_dag()

```

**Example of push pull data between tasks using combination of xcom with 2.0 and just using 2.0**
1. 
```python
from airflow.decorators import dag, task
from airflow.utils.dates import days_ago

# Define the DAG using the @dag decorator
@dag(schedule_interval='@daily', start_date=days_ago(1), catchup=False, tags=['example'])
def xcom_example_dag():
    
    # Task to push data to XCom
    @task
    def push_data():
        data = "Hello, XCom!"
        return data  # This implicitly pushes data to XCom

    # Task to pull data from XCom
    @task
    def pull_data(ti):
        # Pull data from XCom using xcom_pull
        data = ti.xcom_pull(task_ids='push_data') #---xcom_pull is being used here. 
        print(f"Pulled data: {data}")

    # Define task dependencies
    data_pushed = push_data()
    pull_data()

# Instantiate the DAG
dag_instance = xcom_example_dag()
```
**Just using 2.0 Airflow**
```python
from airflow.decorators import dag, task
from airflow.utils.dates import days_ago

# Define the DAG using the @dag decorator
@dag(schedule_interval='@daily', start_date=days_ago(1), catchup=False, tags=['example'])
def direct_passing_example_dag():
    
    # Task to return data
    @task
    def push_data():
        return "Hello, TaskFlow!"  # Return data directly

    # Task to receive data as a function argument
    @task
    def pull_data(data):
        print(f"Pulled data: {data}")

    # Define task dependencies and pass data directly
    data = push_data()
    pull_data(data)

# Instantiate the DAG
dag_instance = direct_passing_example_dag()
```


