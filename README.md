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

| Variable         | Description                               |
|------------------|-------------------------------------------|
| SYSTEM_NAME      | The name of the OpenShift system.         |
| OSO_WEB_UI_URL   | The URL of the OpenShift web UI.          |
| OSO_REGISTRY_URL | The URL of the OpenShift registry web UI. |

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
from the included Dockerfile:

```bash
sudo docker build . -t rahti-mkdocs-server
```

Then run the container, making sure to set all the necessary environment
variables. For example:

```bash
sudo docker run -it -p 8000:8000 \
--name rahti-user-guide \
-e SYSTEM_NAME=Rahti \
-e OSO_WEB_UI_URL=https://rahti.csc.fi:8443 \
-e OSO_REGISTRY_URL=https://registry-console.rahti.csc.fi \
rahti-mkdocs-server
```
