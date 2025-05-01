**Networking** is another building block for hosting your work on the cloud.

### What is a network? 
A network is simply a collection of devices connected together, where each connection can be a request sent from one device to another or a response to a request. When you create and use resources on AWS, you want these resources to communicate with each other and possibly with the outside internet. Enabling the communication between resources and with the outside world requires an understanding of some basic cloud networking concepts. This includes understanding what an IP address is and how to create a network for your resources on AWS using VPC (Virtual Private Cloud) and subnets.

### What is an IP address?
In a given network, each device is assigned an IP (Internet Protocol) address, which is a series of digits that uniquely identifies each device within the network. These addresses ensure that responses and requests are sent to the correct device. 

There are many types of IP addresses. IPv4 is the most widely integrated version of the IP address system.  An IPv4 address is a 32-bit integer that can be expressed in hexadecimal notation in the form of x.x.x.x. In decimal notation, each x is an 8-bit number that can take a value between 0 and 255. For example, 192.101.0.2 is a valid IPv4 address.  


Another related term you will encounter when working on the cloud is CIDR (Classless Inter-Domain Routing) notation. A CIDR notation represents a range of IP addresses that could be assigned to devices within a particular network. CIDR is used to provision the required number of IP addresses for a particular network and reduce wastage of IP addresses. The following is an example of CIDR notation:

192.101.0.0/24

This notation means that the first 24 bits are fixed and the last 8 bits can be any bits. In other words, 192.101.0.0/24 represents all IP addresses between 192.101.0.0 and 192.101.0.255.

### What is a VPC?
A VPC (Virtual Private Cloud) is an isolated private network where you can launch your AWS resources. A VPC exists inside a region, which can contain more than one VPC, and a VPC spans multiple availability zones inside the region. VPC is a way to isolate your resources (for example EC2) from the outside world. Think of it as a box or a wall that protects and organizes your resources. Resources within the same VPC can communicate with each other. By default, there’s no communication between resources from different VPCs or with the internet unless you allow it to happen by properly configuring the VPC.  

When you create a VPC, you need to specify the range of IP addresses or the CIDR block for the network, which determines the size of the network. Each resource created inside the VPC will be assigned an IP address from the specified range. When you launch resources such as EC2, you need to make sure they’re launched inside a VPC.

### What is a subnet?
Inside your VPC, you may need some resources to be public and others to be private. You can achieve this by creating subnets within your VPC. Subnets provide you with more detailed control over access to your resources. Each VPC consists of subnets created inside availability zones. You can create a public subnet if you want to allow for outside traffic to access your resources, and you can create a private subnet if you don’t want to allow for outside traffic to access your resources.

You can think of a subnet as a smaller network inside your base network. Each subnet is assigned a CIDR block, which must be a subset of the VPC CIDR block. Resources in multiple subnets of the same VPC can communicate because they are part of the same VPC.  