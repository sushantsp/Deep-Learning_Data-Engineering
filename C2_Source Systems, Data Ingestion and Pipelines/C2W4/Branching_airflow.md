Branch operators in Airflow dynamically direct task flow, deciding which subsequent task to execute next based on a specified condition. For instance, consider the following DAG:

![image](.images/Branching_Airflow_1.png)

In the first task, you extract data from an API and compute a certain ratio. In the second task , you check the value of the ratio: if this value is greater than half, you execute the task ‘print_greater’, otherwise you execute the task ‘print_less’. And finally, you execute the last task ‘do_nothing’ regardless of which task was previously executed. 

Let’s see this example in code form. We'll take a look at the code written based on the traditional paradigm and the code written with TaskFlow API.

### Traditional Paradigm

First you define the DAG and its tasks as usual:
```python

with DAG(dag_id="branching", start_date=datetime(2024, 3, 13), schedule='@daily', catchup=False):
    task_1 = PythonOperator(task_id='extract_data', python_callable=extract_from_api)
    task_2 = BranchPythonOperator(task_id='check_ratio', python_callable=check_ratio)
    task_3 = PythonOperator(task_id='print_greater', python_callable=print_case_greater_half)
    task_4 = PythonOperator(task_id='print_less', python_callable=print_case_less_half)
    task_5 = EmptyOperator(task_id='do_nothing', trigger_rule = 'none_failed_min_one_success')
    
    task_1 >> task_2 >> [task_3, task_4] >> task_5

```

Note that for the last task ('do_nothing'), we needed to specify the parameter trigger_rule as follows: `trigger_rule ='none_failed_min_one_success'`. 
This is because we want this task to execute regardless of which previous task was executed, otherwise it will be skipped.

Now, let’s check out the function of each task. 

This is the first function: **extract_from_api**.

```python

def extract_from_api(**context):
   import requests
   number_posts = 40
   location = "usa"
   url_link = "https://jobicy.com/api/v2/remote-jobs"
   response = requests.get(url_link, params={"count": number_posts, 
                                             "geo": location, 
                                             "industry": "engineering",
                                             "tag": "data engineer"}).json()
   count = 0
   for job in response['jobs']:
       if job['jobLevel'] == 'Senior':
           count += 1
   ratio = count / len(response['jobs'])
   context['ti'].xcom_push(key='ratio_us', value=ratio)
```

Now let’s check out the function **check_ratio** that corresponds to the BranchPythonOperator:
```python
def check_ratio(**context):
   if float(context['ti'].xcom_pull(key='ratio_us', task_ids='extract_data'))>0.5:
       return 'print_greater' #task_id of the greater than case
   return 'print_less' #task_id of the less than case
```
You can see that it's a regular if statement, but it returns the id of the task that should be executed in each case. 

And finally, let's check out the functions of the remaining tasks:

```python

def print_case_greater_half(**context):
   print("The ratio is greater than half: " + str(context['ti'].xcom_pull(key= 'ratio_us', task_ids='extract_data')))

def print_case_less_half(**context):
   print("The ratio is less than half: " + str(context['ti'].xcom_pull(key= 'ratio_us', task_ids='extract_data')))

```

### TaskFlow API
Here's the equivalent code written with TaskFlow API

```python
from airflow import DAG
from datetime import datetime
from airflow.decorators import dag, task

@ dag(start_date=datetime(2024, 3, 13),schedule='@daily', catchup=False)
def example_branching():
    @task
    def extract_from_api():
        import requests
        number_posts = 40
        location = "usa"
        url_link = "https://jobicy.com/api/v2/remote-jobs"
        response = requests.get(url_link, 
                    params={"count": number_posts,  
                            "geo": location, 
                            "industry": "engineering",
                            "tag": "data engineer"}).json()
        count = 0
        for job in response['jobs']:
            if job['jobLevel'] == 'Senior':
                count += 1
        ratio = count / len(response['jobs'])
        return ratio

    @task.branch()
    def check_ratio(ti=None):
        if float(ti.xcom_pull(task_ids='extract_from_api')) > 0.5:
            return 'print_case_greater_half' # task_id of the greater than case
        return 'print_case_less_half'  # task_id of the less than case

    @task
    def print_case_greater_half(ti=None):
        print( "The ratio is greater than half: " +
                str(ti.xcom_pull(task_ids='extract_from_api')))

    @task
    def print_case_less_half(ti=None):
        print("The ratio is less than half: " +
                str(ti.xcom_pull(task_ids='extract_from_api')))

    @task(trigger_rule='none_failed_min_one_success')
    def empty_task():
        pass
    
    extract_from_api() >> check_ratio() >> [print_case_greater_half(), print_case_less_half()] >> empty_task()


example_branching()
```

Note the use of decorator: `@task.branch()` , which is the decorated version of the BranchPythonOperator. 
Also note that for the empty task, we used the operator `@task` and we defined a Python function that does nothing. 
Also to specify the trigger_rule for this task, we passed them to the task decorator: `@task(trigger_rule='none_failed_min_one_success')`

Also note how the task instance is accessed when calling `xcom_pull`: in the example you saw in the previous video, 
you saw that you can pass in the entire Airflow context dictionary to the task function (**context), 
and then access the task instance as follows: `context[‘ti’]`. Instead of passing the entire dictionary, 
you could just pass the task instance as follows: `def check_ratio(ti=None)` (instead of def check_ratio(**context))
