# Rahti user guide

The user guide for the Rahti OpenShift systems.

## Editing the documentation

The guide is written using the [Markdown markup
language](https://en.wikipedia.org/wiki/Markdown).
[MkDocs](http://www.mkdocs.org/) is used to generate static documentation pages
out of the Markdown files.

Markdown can be edited using any text editor, but you will need to install
MkDocs if you wish to preview your changes while editing your documentation. You
can find installation instructions in the [MkDocs
documentation](http://www.mkdocs.org/#installation).

Before building the site from the markdown sources, you will need to set some
environment variables:

| Variable             | Description                                         |
|----------------------|-----------------------------------------------------|
| GITLAB_LOGIN_SUPPORT | Whether the system supports GitLab logins.          |
| LDAP_LOGIN_SUPPORT   | Whether the system supports LDAP logins.            |
| OPENSHIFT_VERSION    | What version of OpenShift is in use.                |
| OSO_REGISTRY_URL     | The URL of the OpenShift registry web UI.           |
| OSO_WEB_UI_URL       | The URL of the OpenShift web UI.                    |
| SUI_INTEGRATION_DONE | Whether it is possible to apply for access via SUI. |
| SYSTEM_NAME          | The name of the OpenShift system.                   |

When these are set in the environment, you can create a config file for mkdocs:

```bash
./make_config.sh
```

Afther doing this, you can start a preview web server from the command line
while in the root of the project directory:

```bash
mkdocs serve
```

This will start a web server on your computer listening on port 8000. Point your
web server to [localhost:8000](http://localhost:8000) to get a preview of the
documentation.

The configuration for MkDocs is in the mkdocs.yml file in the root of this
repository. The name of the documentation site, the structure of the
documentation pages and the theme to use for the site are described in this
document.

The documentation files themselves are under the docs directory.

## Using the included Dockerfile

You can also create a Docker container to host the docs. First build an image
from the included Dockerfile, making sure to set all the necessary environment
variables. For example:

```bash
sudo docker build -t rahti-user-guide \
  --build-arg SYSTEM_NAME=Rahti \
  --build-arg OSO_WEB_UI_URL=https://rahti.csc.fi:8443 \
  --build-arg OSO_REGISTRY_URL=https://registry-console.rahti.csc.fi \
  --build-arg LDAP_LOGIN_SUPPORT=1 \
  --build-arg GITLAB_LOGIN_SUPPORT=0 \
  --build-arg SUI_INTEGRATION_DONE=1 \
  --build-arg OPENSHIFT_VERSION=3.9 .
```

Then run the container:

```bash
sudo docker run --rm -it -p 8000:8000 --name rahti-user-guide rahti-user-guide
```

## Hosting on OpenShift

The Dockerfile is also made to be compatible with OpenShift, so it should work
with the source-to-image mechanism when using `oc new-app`. First create a new
project to host the user guide:

```bash
oc new-project rahti-user-guide
```

Then run `oc new-app` to create the user guide deployment:

```bash
oc new-app \
  --build-env SYSTEM_NAME=Rahti \
  --build-env OSO_WEB_UI_URL=https://rahti.csc.fi:8443 \
  --build-env OSO_REGISTRY_URL=https://registry-console.rahti.csc.fi \
  --build-env LDAP_LOGIN_SUPPORT=1 \
  --build-env GITLAB_LOGIN_SUPPORT=0 \
  --build-env SUI_INTEGRATION_DONE=1 \
  --build-env OPENSHIFT_VERSION=3.9 \
  https://github.com/CSCfi/rahti-user-guide.git#master
```

In the command above, the `#master` at the end specifies the branch to use. If
you have a feature branch that you would like to test on OpenShift, you can
specify a branch different from master.
