# Containers

Containers are a technology that is based on operating system kernel features
that allow the creation of isolated environments that all share the same kernel.
For example, container features make it possible to have several isolated root
filesystems, network stacks and process trees that all share the same kernel.
These isolated environments are similar in functionality to light weight virtual
machines, but there are some key differences between virtual machines and
containers. The biggest one is that virtual machines always have their own
kernel, while containers share the host system's kernel.

![The difference between virtual machines and containers](img/vm_vs_container.png)
*The difference between virtual machines and containers.*

While many operating systems have container functionality, what we look at more
specifically in this documentation is containers in the Linux operating system.
Linux is the most popular operating system for running containers, and it is
also the operating system used in the Rahti container cloud. Currently the most
popular method for using container functionality in Linux is Docker. It provides
a set of tools that make it easier to use containers compared to using the
kernel functionality directly. Docker provides:

  * A runtime (runC) for containers
  * An image format for containers
  * A command line interface for running and managing containers and images
  * The Dockerfile format for building Docker images

Docker has popularized containers by making them easier to use. Instead of
looking at kernel documentation and figuring out how to use the different
interfaces to the kernel's container features and then having to figure out
which features you want to use and how, Docker provides a simpler way to start
containers with a single command line command. The specific kernel features and
how to use them have been defined by Docker.

As an example of how Docker is used, this is how you could start a container on
your computer after installing Docker:

```bash
docker run -it ubuntu
```

This will download the "ubuntu" image if it is not already present on the
computer, start a container based on that image and give the user a command line
interface within the container. From the user's point of view the experience is
similar to starting a virtual machine: regardless of the operating system
distribution on your computer, interacting with the container will seem like you
are interacting with a Ubuntu installation.

After running that command, you should be able to see the Ubuntu Docker image
that has been downloaded by listing images:

```bash
docker images
```

You can also do many other things, like launch containers in the background,
attach to a running container to interact with it or build your own Docker
images from a Dockerfile. The examples given here are meant to give a general
idea about what using containers is like from the user's perspective. For more
complete documentation about Docker, see the
[official Docker documentation](https://docs.docker.com/).

# Container orchestration

To understand why container orchestration platforms are important, let's
describe how a typical web based application that end users access via a web
browser is built.

The application is comprised of a frontend that is the part of the application
visible to users and a backend that handles various tasks in the background like
storing user data in a database. The application runs a server process that
clients access to interact with the application. It also accesses a database
like PostgeSQL or MongoDB in the background to store user data.

The architects of this application must design it to keep the application
running reliably, quickly and safely:

  * Server hardware can fail, so the application must be replicated to multiple
    physical servers so that the failure of an individual server won't make the
    entire application inaccessible.
  * A large number of users can cause load on the application. It must be
    possible to scale up the application by adding more application processes to
    prepare for increased user load.
  * The connection to the application must be secure so that users can safely
    enter their data into the application without fearing eavesdroppers.
  * User data must be stored reliably on a fault tolerant storage system.

You could create Linux virtual machines, install Docker on them and run the
application directly using those, but there is a lot of additional work that you
need to do to fulfill all of the above requirements. You would have to figure
out how to manage multiple instances of the application running on several
servers, how to direct incoming traffic evenly to all the application instances,
how to store user data and how to quickly add more capacity when needed.

Luckily most applications have similar requirements, so the steps for creating
good applications are often quite similar. This is where container orchestration
systems come in. They handle many of the common tasks required for running
robust web applications like distributing application instances on multiple
servers, directing traffic to the application instances and providing persistent
storage for databases.

Currently the most popular software for container orchestration is Kubernetes.
It is based on earlier systems developed at Google over a decade. The Rahti
system is based on a distribution of Kubernetes called OpenShift that is made by
Red Hat.
