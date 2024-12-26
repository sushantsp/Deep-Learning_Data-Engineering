## Week 4 : Stakeholder Management and Gathering requirements (Personal Notes)

This week talks about the How to talk and manage with stakeholders. And then gather requirements. In this case specific to data pipe lines or data systems.


### Thinking like a DE - Complete Mental model !!

![image](./Complete%20Mental%20Model.png)

The above is the summary of first three weeks and we specifically dwelved on building a small data pipeline to understand DE lifecycle and its undercurrents. Week 3 helped us understnd the priciples of data architect. In this we developed a web application to serve to end users. 
    
    We used APACHE BENCHMARK for stress test the application we built. It helps you simulate the traffic to the application you built.  Started we two ec2 systems - ALB (Automatic load balancer) defines the threshold when to increase the no of ec2 systems and buffer time for systems to load then up and rinning. 


* FinOps and Cost efficiency Pillar -  As a part of efficiency, we managed to change the type of ec2 systmes. from `t2.micro` to `t3.nano`. 
* Autoscalling allowed you architecting for scalability. 

* We focussed on reliability pillar by focussing on planning for failure. Having EC2 in other availibility zones. 

Then we also adjusted the security requirements of the application by making sure external users have access to only port 80 and others. 

We monitored the app for usage and activity. 

* Thing to be done in this week.
![Week 4 task](./Practical%20On%20the%20Job%20Scenario.png)

### Requirements
![image](./4_Requirements%20Gathering.png)

* Functional Requiremtns - what the system will be able to do. For ex. It should flag the frads as soon as they happen in system

* Non Functional Requirements - Characteristics. such as latency and scalability. 