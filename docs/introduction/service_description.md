# Scope and description of the service

The Rahti container cloud service is a cloud computing service. The Rahti
service is based on OKD, which is a distribution of Kubernetes. The Rahti
service allows its customers or users to run their own applications on top of
it, often implemented as containers. The Rahti service provides, but is not
necessarily limited to, these resources: 

 * Hosting of container instances, and groups of container instances
 * Storage services 
 * Virtual networks for connecting container instances
 * Load balancing of traffic to user applications
 * Features for replication, rolling updates, auto-recovery and auto-scaling of user user applications
 * Basic default domain name and TLS for hosted web applications (under rahtiapp.fi)

Customers can manage their resources using a web interface accessible through a
web browser and through a set of APIs which allow programmatic management of
resources. In order to access and use the service the customer must have a CSC
user account.

The user's applications are separated from other users’ applications from a
network, storage and computational view.

The Rahti service accounts for service usage based on the resources used. Up to
date resource cost information is found in the [https://rahti.csc.fi](Rahti
documentation).
