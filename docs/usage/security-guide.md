# Foreword

The OpenShift applications exposed to the Internet are public services and
their security should be treated with appropriate care. This means
that the user on whose account the service is running, is 
responsible for the security of it. See [Terms of Service]() for details about
responsibilities.

These guidelines will help your OpenShift applications become more secure.
However, they should be considered to be more of pointers to better security
than fixed set of rules by following of which, a perfect security would be
achieved.

Measures that harden security of the services running in OpenShift fit roughly
in two of the following categories.

## Securing routes

Enable **TLS encryption** of routes. If the DNS name of your service is under
subdomain `rahtiapp.fi` then the TLS certificates and keys provided by rahti
can be used. Otherwise, you need to supply your own keys and certificates to
the Route object.

Services should be accessible only through **whitelists** whenever applicable (See
Chapter "[Routes](../tutorials/elemental_tutorial#routes)"). This is relevant
whenever the service can be restricted in terms of IP addresses.

## Image security

Another, more involved stance in hardening service security is to consider the
security issues of the container images.

A container image should be used only if

1.  It is from a known and trusted source
2.  You have reviewed its Dockerfile build configuration and the base layer
    satisfies Rule #1 or #2

Other things to keep in mind:

* Use curated images.
* Prefer images that regularly receive security updates.
* Use static container image analysis tools if available.
* The smaller the image, the less there is "surface area" for attacks:
    * Utilize the builder pattern in your images if you use compiled languages:
      Build the binary in a different image than where the application is
      deployed to. In Docker, this can be achieved with
      [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/),
      and in OpenShift, directories of other images may be mounted during build process.
      This way, only essential pieces of software are installed in the
      deployment image.
    * In interpreted languages, use language based images: Instead of
      installing Node.js on top of Debian image use, e.g., `node:8-debian`.

## Threat models

Below is a non-exhaustive list of threat models and mitigations to them.

| Threat | Mitigation |
|:-------|:-----------|
| Eavesdropping attack when using HTTP protocol for secure information. | Use HTTPS protocol. |
| User's password is leaked. | Restrict userbase. Restrict user access rights. Deny user from accessing the container's console. |
| Application is compromised remote attackers by technical security vulnerability. | Keep images updated. Follow security updates. Follow `rahti-users` mailing list. Utilize image scanning services. |
| Container image includes malware code | Be mindful what container images to use. |
