# Introduction

In this tutorial Kubernetes' core concepts Pods, Services, Routes and ReplicationControllers and their YAML representations are discussed.

In these examples, a apache http server is started from container image included in openshift by default and the server is exposed at myservice-my-project-with-unique-name.rahtiapp.fi.

Minimally we need the following objects defined in the cluster to have the server running:

1. Pod that runs the container
2. Service that exposes the pod internally and gives it a predictable name to refer
3. Route that will expose the Service in 2. to outer world and redirects
   `myservice-staticserve.rahtiapp.fi` to the given service object.

!!! Note 
    One should not deploy applications the way described in this documentation. This tutorial is meant for learning the core concepts of Kuberenetes, instead. If you already know about pods, services and routes, you might be interested in the chapter [Advanced concepts](/tutorials/advanced_tutorial).

Having said that, lets go ahead and define the pod, service, route and the replication controller manually.

## Preparations

If you are logged in to Rahti web console and have the OpenShift command line tool `oc` installed, you can skip this section now. 

Install the `oc` command line tool and authenticate a command line session by logging in to rahti at https://rahti.csc.fi:8443/ as follows:

* Install `oc` command line tools by clicking the question mark -> "Command Line Tools" at up right corner of OKD console: 

  ![install cli menu](img/cli-menu.png)

  and click the Latest release link:

  ![install cli page](img/cli-page.png)

* Download and unpack correct version for your platform and make sure that the binaries are found in a directory that is in the PATH environment variable.

* Copy login command by clicking here:

    ![copy login](./img/copy-login.png)
 
    and paste the result to terminal, the result should be similar to:

```bash
$  oc login https://rahti.csc.fi:8443 --token=<secret access token>
```

  The secret access token is valid only for limited time, so each time on starts working with `oc` tool, one needs to re-authenticate.

## Projects

The OpenShift command `oc projects` shows the projects one has access to:

```bash
$ oc projects
You have access to the following projects and can switch between them with 'oc project <projectname>':

    someone-elses-public-project
  * my-project-with-unique-name

Using project "my-project-with-unique-name" on server "https://rahti.csc.fi:8443".
```

If there weren't a suitable project, a new is created with `oc new-project`

```bash
$ oc new-project my-project-with-unique-name
``` 

Notice that the name may only contain letters, digits and hyphen symbols and it is not case sensitive.

And switching to an existing project:

```bash
$ oc project another-project
```

The name of the project needs to be unique across rahti container cloud. If you have multiple CSC projects, the description of the project must contain `csc_project: #######`, where `#######` is the project that should be billed. The description can be included in the `new-project` command as follows

```bash
$ oc new-project my-project-with-unique-name --description='csc_project: #######'
```

## Pods and how to create objects using CLI

Pods are objects that keep given number of containers running. The containers in the pod are guaranteed to run on one *node* so that they find each other at `localhost` and they can communicate through shared memory.

Usually pods are not created by hand except in special cases. Instead, higher level objects (Deployments, DeploymentConfigs, etc...) are more often utilized.

In our case, the pod will run the container image with the web server.

*`pod.yaml`*

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    app: serveapp
    pool: servepod
spec:
  containers:
  - name: serve-cont
    image: "docker-registry.default.svc:5000/openshift/httpd"
```

This pod will run one container image given in the field `spec.containers[0].image`. 

* `metadata.name` is the name so that the pod can be referred using, e.g., `oc`:

```bash
oc get pods mypod
```

* `metadata.labels.pool` is just an arbitrary label so that the pod can be referred by, e.g., *services*.

Pods and other Kubernetes/OpenShift API objects are created with the `oc` command line utility as follows:

```bash
$ oc create -f pod.yaml
```

The pod should now appear in OpenShift web console overview if the correct project is viewed in the console.

Pods can be deleted using the `oc delete` command:

```bash
$ oc delete pod mypod
```

Consequently, the pod should disapper from the OpenShift web console, but let's keep the pod running for now.

### Resources

Typically one allocates *resources* to containers, but in these examples we refrain from doing that for the sake of brevity. The same pod as above with memory and cpu resources of 200MB...1GB and 0.2CPU...1CPU would read as:

*`pod.yaml`*:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    app: serveapp
    pool: servepod
spec:
  containers:
  - name: serve-cont
    image: "docker-registry.default.svc:5000/openshift/httpd"
    resources:
      requests:
        memory: "200M"
        cpu: "200m"
      limits:
        memory: "1G"
        cpu: "1"
```

## Service

Service objects provide consistent network identity to pods.

*`service.yaml`*
```yaml
apiVersion: v1
kind: Service
metadata:
  name: serve
  labels:
    app: serveapp
spec:
  ports:
  - name: 8080-tcp
    port: 8080
    protocol: TCP
  selector:
    pool: servepod
```

This service will redirect TCP traffic internally in the project to the pods having labels listed in `spec.selector`. In this case, the service will redirect to all the pods having label `pool: servepod`. If there are multiple pods matching `spec.selector` then traffic is split between pods in a defined way.

## Route

*`route.yaml`*:
```yaml
apiVersion: v1
kind: Route
metadata:
  labels:
    app: serveapp
  name: myservice
  annotations:
    haproxy.router.openshift.io/ip_whitelist: 192.168.1.0/24 10.0.0.1
spec:
  host: myservice-my-project-with-unique-name.rahtiapp.fi
  to:
    kind: Service
    name: serve
    weight: 100
```

This route will redirect traffic from internet to that service in the cluster whose `metadata.name` equals `spec.to.name`. 

This particular route also allows traffic only from subnet `192.168.1.0/24` and the IP `10.0.0.1`. Security-wise it is highly encouraged to utilize ip-whitelisting. 

!!! Caution
    If the whitelist entry is malformed, OpenShift will discard the whitelist and traffic is allowed from everywhere.

* If the service `spec.to.name` has multiple ports defined then one should define `spec.port.targetport`
* By default the hostname is `metadata.name` + `-` + project name + `.rahtiapp.fi` unless otherwise specified in `spec.host`.

So far we have set up a pod, a service and a route. If the physical server where to pod lives gets shut down one has to manually start the pod again with `oc create -f pod.yaml`. The ReplicationController and ReplicaSet objects are mechanism that will, roughly speaking, do that for the user. 

## ReplicationController

A ReplicationController ensures that there are `spec.replicas` number of pods whose labels match `spec.selector.matchLabels` (or `spec.selector.matchExpression`) running in the cluster. If there are too many, ReplicationController will shut down the extra ones and if there are too few, it will start up pods according to `spec.template` field. Actually, the template field is exactly the pod described in `pod.yaml` except the fields `apiVersion` and `kind` are missing. 

*`ReplicationController.yaml`*:

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  labels:
    app: serveapp
  name: blogtest-replicator
spec:
  replicas: 1
  selector:
    matchLabels:
      app: serveapp
      pool: servepod
  template:
    metadata:
      name: mypod
      labels:
        app: serveapp
        pool: servepod
    spec:
      containers:
      - name: serve-cont
        image: "docker-registry.default.svc:5000/openshift/httpd"
```

A central Kubernetes' concept coined *reconciliation loop* manifests in ReplicationControllers. Reconciliation loop is a mechanism that measures the *actual state* of the system, constructs *current state* based to the measurement of the system and performs such actions that the state of the system would equal to the *desired state*.

In such a terminology, ReplicationControllers are objects that describe *desired state* of the cluster. Another such an object is the service object encountered earlier. There is an another reconciliation loop that compares the endpoints of the service the actual pods that are *ready* and adjusts accordingly. As a result, the endpoints of the service always point to pods that are ready and only those pods whose labels contain all the fields in the selector of the service object. In fact, every incidence of `spec` in a YAML representations of Kubernetes objects, describes a specification for a reconciliation loop. The loops for pods just happen to be tied to the worker nodes of Kubernetes and are thus susceptible to deletion if/when the worker nodes are deprovisioned.

## Conclusion

In this tutorial a static web page server was set up using YAML files representing the Kubernetes objects. The created objects can be further modified in the OpenShift web console where, e.g., 

* Routes can be modified to be secure ones encrypted by TLS,
* autoscalers, storage, resource limits and health checks can be added to ReplicationControllers, and
* new routes can be added to Services.

---


## Short introduction to YAML

YAML is used to describe key-value maps and arrays. You can recognize YAML file from `.yml` or `.yaml` file suffix.

A YAML dataset can be

* Value

```yaml
value
```

* Array

```yaml
- value 1
- value 2
- value 3
```
or 
```yaml
[value 1, value 2, value 3]
```

* Dictionary
    
```yaml
key: value
another_key: another value
```
or
```yaml
key:
  value
another_key:
  another value
```

* YAML dataset

```yaml
key:
  - value 1
  - another key:
      yet another key: value of yak
    another keys lost sibling:
      - more values
    this key has one value which is array too:
    - so indentation is not necessary here since keys often contain arrays
```

Values can be inputted across multiple lines with `>`:

```yaml
key: >
  Here's a value that is written over multiple lines
  but is actually still considered a single line until now.

  Placing double newline here will result in newline in the actual data.
```

Verbatim style is supported with `|` character:

```yaml
key: |
  Now the each
  newline is
  treated as such so
```

YAML is also a superset of JSON (JavaScript Object Notation), so

```json
{
  "key": 
  [
    "value 1",
    {
      "another key": {"yet another key": "value of yak"},
      "another keys lost sibling": ["more values"],
      "this key has one value which is array too": ["so indentation is not necessary here since keys often contain arrays"]
    }
  ]
}
```

is also YAML.

For more information, see [yaml.org](https://yaml.org/) or [json.org](https://json.org).


