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

Once you've installed MkDocs, you can start a preview web server from the
command line while in the root of the project directory:

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
