# Rahti Container Cloud Service Service Level Agreement DRAFT

## General

This Service Level Agreement (hereafter called SLA) is made between the
customer, Rahti Container Cloud Service and the service provider, CSC - IT
Center for Science Ltd., to cover the provision and support of the service as
described hereafter. Amendments, comments and suggestions must be addressed
using the communication channels defined in section 8.1. The service provider
retains right to introduce changes to the infrastructure. If the Customer does
not accept the changes, this service subscription can be terminated.

## Scope and description of the service

This SLA applies to Rahti Container Cloud Service1 (hereafter referred to as
Rahti or the Rahti service). The Rahti service is a cloud computing service.
The Rahti service is based on OKD, which is a distribution of Kubernetes. The
Rahti serviceallows its customers or users to run their own workloads on top of
it, often implemented as containers.  The Rahti service provides, but is not
necessarily limited to, these resources: 

 * Container instances, and groups of container instances
 * Storage services 
 * Virtual networks for connecting container instances
 * Load balancing of traffic to user workloads
 * Features for replication, rolling updates, auto-recovery and auto-scaling of user workloads
 * Basic default domain name and TLS for hosted web applications (under rahtiapp.fi)

Customers can manage their resources using a web interface accessible through a
web browser and through a set of APIs which allow programmatic management of
resources. In order to access and use the service the customer must have a CSC
user account. The workloads are separated from other customers’ workloads from
a network, storage and computational view.

This service is provided under User policy and terms of usage for the Rahti
contariner cloud service hence by agreeing to this document the customer also
agrees with CSC General Terms of Use and CSC’s Security Policy.

## Service hours & exceptions

The service is designed to run continuously. However, the following exceptions apply:

Scheduled maintenances:

 * Planned service breaks - Announced to the customer at least three weeks in advance
 * Unplanned service breaks

## Service components & dependencies
The service covered by this SLA is made up of the following (technical and logical) service components:

 * Kajaani datacenter infrastructure
 * Funet network
 * CSC’s helpdesk
 * CSC’s cPouta service
 * CSC’s identity management service

## Support

Support to the services covered by the scope of this SLA are provided through
CSC Service Desk channels and under CSC Service Desk policies:

| CSC Service Desk ||
--- | ---
Operating hours | Mon-Fri (Excluding Finnish public holidays), see https://www.csc.fi/en/web/guest/customer-service
Phone |  +358 (0) 94 57 2821
E-Mail | servicedesk@csc.fi
Webpage and contact form | https://research.csc.fi/cloud-computing https://research.csc.fi/support
Response time target | Within Three Working Days

###  Incident handling

Disruptions to the agreed service functionality or quality will be handled
according to an appropriate priority based on the impact and urgency of the
incident. In this context, the following general priority guidelines apply:

1. Ensuring normal levels of security
2. Restoring normal service operation
3. Restoring customer workloads where possible

Response and resolution times are provided as service level targets (see section 6).

### Fulfilment of service requests

In addition to resolving incidents, the following standard service requests are
defined and will be fulfilled through the defined support channels:

 * Issues regarding CSC’s identity management service
 * Issues using this service’s web interface
 * Issues using the provided APIs
 * Issues deploying workloads
 * Issues using workload templates

Response and fulfilment times are provided as service level targets (see section 6).

## Service level targets

The Rahti service level targets adhere to JHS1745 as follows:

Service level targets ||
--- | ---
Service Level | B (normal)
Service time / incident handling | P2 Weekdays 7.00-19.00
Availability | K2 99%
Response | V2 reaction: 2h, solution: 1 BD

Availability is calculated by subtracting the service break time from the ideal
availability during service time. This information is obtained from internal
monitoring systems and defined as Customers’ ability to manage their workloads,
and the availability of the workloads.

The Service Provider commits to inform the customer if this SLA is violated or
a violation is anticipated. For this, email as a communication channel will be
used. 

A Customer contacts the CSC Service Desk for the case of a possible SLA
violation. The case will be analysed internally and, if the violation is
confirmed, CSC will inform the Customer about the reasons for the violation,
planned mitigation actions and expected resolution time.

## Limitations and constraints

The provisioning of the service under the agreed service level targets is subject to the following limitations and constraints: 

 * Support is provided primarily in the following languages: English, Finnish
 * Downtimes caused due to upgrades for fixing critical security issues are not considered SLA violations. In the case of critical security upgrades CSC reserves the right to apply the upgrades with minimal notice
 * A technical failure which affects individual customers does not count as downtime
 * Failures of single instances of the workload (containers) are expected behaviour, and does not count as downtime
 * Any other causes outside service provider’s direct control

## Communication, reporting and escalation

### General communication

The following contacts will be generally used for communications related to the
service in the scope of this SLA:

| Communication channels ||
--- | ---
Contact for Customers | servicedesk@csc.fi
Security incident reporting | (CSC’s Head of Security) security@csc.fi +358 (0) 94 57 2253

### Reporting
The service availability information is…. The information provided will be limited to service availability and by data security and privacy constraints.

### Escalation and complaints

For escalation and complaints, the defined contact point shall be used, and the
following rules apply:

1. First contact shall be established, preferably by e-Mail, to Contact for Customers address (See section 8.1) explaining the reason for the complaint with a sensible level of detail and clarity. Please also include, if possible, the following information:
    * Name of the service
    * Date and time of the events
    * Usernames of affected users
    * Channel to use on following communications (If other is preferred)
2. CSC Service Desk will contact you back within three working days with information about the incident and which procedures will be adopted. 

## Information security & data protection
 CSC has approved a security policy and also follows security best practices.
For CSC's customers, partners and staff there are detailed security guidelines.
Many items in our security policies and guidelines refer to external compliance
requirements. CSC also has procedures for risk and security management. For
more information, please refer to the following pages:

https://www.csc.fi/security

https://www.csc.fi/web/research/rahti-security

The handling of personal information on the Rahti service is described here.

https://www…..

## Additional responsibilities of the Service Provider

Additional responsibilities of the Service Provider are as follow:

 * Adhere to all applicable operational and security policies and procedures defined in CSC’s Security Policy (See section 9) and to other policy documents referenced therein
 * Use communication channels defined in the agreement
 * Provide monitoring data to measure fulfillment of agreed service level targets.

## Customer responsibilities

The Customer agrees to follow the General Terms of Use for CSC's Services for
Science7, User policy and terms of usage for the Rahti container cloud service8
and CSC’s Security Policy9.

## Review

There will be reviews of the service performance against service level targets
and of this SLA at planned intervals according to the following rules: 

 * Annual reviews are done internally and based on customer feedback
 *  Major changes to the service may trigger a review.

## Glossary of terms

For the purpose of this SLA, the following terms and definitions apply:

SLA – Service Level Agreement (this document)

Response time – Time spent between the arrival of a customer’s support request
and the first response from CSC Staff

Working days – Monday to Friday (Excluding Finnish public holidays)

Working hours – as defined in https://www.csc.fi/en/web/guest/customer-service

An extended list of term definitions adopted on this document can be found in
the FitSM-0: Overview and vocabulary10 document.
