# Foreword

The OpenShift applications that are exposed to the Internet must be treated as
any service running in Internet. In essence, this means that the user(s) on
whose account the service is running and reachable, is responsible for the
security of it. See [Terms of Service]() for details about responsibilities.

Following these guidelines will result your OpenShift applications be more
secure. However, these guidelines should be considered more of a pointers to
better security than fixed set of rules by following of which, a perfect
security would be achieved.

## Whitelists

Whenever your service can be reached from a set of static IP addresses, use
whitelists. For example use, see
"[Routes](../tutorials/elemental_tutorial#routes)" Chapter.

## Be mindful what containers to use

Never under any circumstances use container image unless

1.  It is from a known and trusted source.
2.  You have reviewed its Dockerfile build and the base layer satisfies Rule
    #1, or you happen to know otherwise what is in the image.

Other things to keep in mind:

* Prefer OpenShift bundled images *[TODO: how to list/get information about
  these]*
* Prefer images that regularly receive security updates. A one family
  of such kind is the Centos images.
* The smaller the image, the less there is "surface area" for attacks. Prefer
  Alpine based images for base images.
    * Utilize the builder pattern in your images if you use compiled languages:
      Build the binary in a different image than where the application is
      deployed to. In Docker, this can be achieved with [multi-stage
      builds](https://docs.docker.com/develop/develop-images/multistage-build/),
      and in OpenShift, one can mount other images during build process.
    * In interpreted languages, use language based images: Instead of
      installing Node.js on top of Debian image consider using `node:8-debian`
      or, even better, `node:8-alpine`

## Threat models

Here is a non-exhaustive list of threat models and mitigations to them.

| Threat | Mitigation |
|:-------|:-----------|
| Eavesdropping attack when using HTTP protocol for secure information. | Use HTTPS protocol |
| User's password is leaked. | Restrict userbase. Restrict user access rights. Don't allow user to use console. |
| Application is compromised remote attackers by technical security vulnerability. | Keep images updated. Follow security updates. Follow `rahti-users` mailing list.|
