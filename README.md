# Rahti 2 landing page

The landing page for the new version of Rahti system. 

## Editing the landing  page

Changes can be made directly to the [html template](index.html.j2).


Before parsing the template, you will need to set some
environment variables:

| Variable                                   | Description                                  |
|--------------------------------------------|----------------------------------------------|
| CLUSTER_LANDING_PAGE_ENV_VERSION           | Openshift / Kubernetes version in new Rahti. |
| CLUSTER_LOGIN_URL_OIDCIDP                  | URL to login console of new Rahti.           |
| CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION | Openshift / Kubernetes version in old Rahti. |
| CLUSTER_LANDING_PAGE_NEWS                  | News to share in the landing page.           |


When these are set in the environment, you can generate the html page using:

```bash
./make_config.sh
```


## Using the included Dockerfile

You can also create a Docker container to host the landing page. First build an image
from the included Dockerfile, making sure to set all the necessary environment
variables. For example:

```bash
sudo docker build -t rahti-user-guide \
  --build-arg CLUSTER_LANDING_PAGE_ENV_VERSION="OpenShift 4.13 / Kubernetes 1.26" \
  --build-arg CLUSTER_LOGIN_URL_OIDCIDP="https://console-openshift-console.apps.2.rahti.csc.fi" \
  --build-arg CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION="OpenShift 3.11 / Kubernetes 1.13" \
  --build-arg CLUSTER_LANDING_PAGE_NEWS="This exciting news to share" .
```

Then run the container:

```bash
sudo docker run --rm -it -p 80:8000 --name rahti-user-guide rahti-user-guide
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
  --build-env CLUSTER_LANDING_PAGE_ENV_VERSION="OpenShift 4.13 / Kubernetes 1.26" \
  --build-env CLUSTER_LOGIN_URL_OIDCIDP="https://console-openshift-console.apps.2.rahti.csc.fi" \
  --build-env CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION="OpenShift 3.11 / Kubernetes 1.13" \
  --build-env CLUSTER_LANDING_PAGE_NEWS="This exciting news to share" \
  https://github.com/CSCfi/rahti-user-guide.git#rahti-2-landing
```

In the command above, the `#rahti-2-landing` at the end specifies the branch to use. If
you have a feature branch that you would like to test on OpenShift, you can
specify a branch different from rahti-2-landing.
