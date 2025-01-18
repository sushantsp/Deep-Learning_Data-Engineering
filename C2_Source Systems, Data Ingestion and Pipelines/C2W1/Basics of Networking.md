Basics of IAM and Permissions are outlined in the week readme.md. Please refer that page.


## Basics of Networking in the cloud
Regions - Multiple availibility zones - data centers

Single VPC can consist of multiple availability zones. But it cannot span across regions. Under each VPC there are subnets. Private subnets and public subnets. Based on the type of application you have, the usage of these differs. you host services on these subnets. 


![alt text](<.images/basics of networking_1.png>) 

![alt text](<.images/basics of networking_2.png>) 

![alt text](<.images/basics of networking_3.png>) 

![alt text](<.images/basics of networking_4.png>)

ACL - Access Control Lists.

## AWS Networking Overview - VPCs and Subnets

Notes to come here. 

## Internet Gateways and NAT Gateway

VPC is a closed network by default. By its own there is no way to access internet outside. No public subnet will be accessible via the internet and no internet resources is alloed to access from the subnet. 

* Its like creating the house without the door. You are inside the house and can move from room to room but cant go outside.
You need to install the door to your VPC to get the public internet access. 

* Installng a door to your house is like providing the internet gateway to your VPC which isolated when it created. Even if your some subnets are private they would still need access to for many reasons such allowing ALB to get to the resource. 
or for upgrades and patching. This one support outbound and inbound traffic. Internet gateways are attached to only one vpc and one vpc can only be connected to one gateway. This is 1to1 relationship. 

![alt text](.images/internet_gateway_1.png) 
![alt text](.images/internet_gateway_2.png)

shows setting up the Internet gateway and adding NAT gateways to Public subnets. 
![alt text](.images/internet_gateway_3.png) ![alt text](.images/internet_gateway_4.png)

## Route Tables

Route Tables are essential for routing traffic within your VPC. VPC createa default route table for internal communicattion withing the VPC.


## Network ACLs and Security Groups
![alt text](<.images/Network ACLs and Sec Groups_1.png>) 
![alt text](<.images/Network ACLs and Sec Groups_2.png>)