# Using OpenShift extensions

In this example we'll explore creating the `serveapp` using OpenShifts extensions `DeploymentConfig`, `ImageStream` and `BuildConfig`. Roughly speaking, their role in the process is this:

* BuildConfig objects build container images based on source files
* ImageStream objects that emit signals when they see that a new image is uploaded into it by, e.g., BuildConfig
* a DeploymentConfig objects create new ReplicationControllers based on the new images

## DeploymentConfig

DeploymentConfig is an object that create ReplicationControllers according to `spec.template`. However, the difference to the ReplicationController is that DeploymentConfig can start new ReplicationController based on state of `spec.triggers`. They function similarly to Deployments described in [Background](/introduction/background) except they can get triggered by new images.

*`deploymentconfig.yaml`*
```yaml
apiVersion: v1
kind: DeploymentConfig
metadata:
  labels:
    app: serveapp
  name: blogdeployment
spec:  
  replicas: 1
  selector:
    app: serveapp
    deploymentconfig: blogdeployment
  strategy:
    activeDeadlineSeconds: 21600
    type: Rolling
  template:
    metadata:
      labels:
        app: serveapp
        deploymentconfig: blogdeployment
    spec:
      containers:
      - name: serve-cont
        image: "serveimagestream:latest"
  triggers:
  - type: ConfigChange 
  - imageChangeParams:
      automatic: true
      containerNames:
      - serve-cont
      from:
        name: serveimagestream:latest
    type: ImageChange
```

In this case, the DeploymentConfig object will listen to *ImageStream* object `serveimagestream:latest`.

## ImageStream

ImageStreams simplify image names and get triggered by a BuildConfig if new
images are being uploaded to the registry. In the case where a new image is
uploaded, it can trigger its listeners to act. In the case of our
DeploymentConfig, action would be to do a rolling update for the pods that it is
meant to deploy.

A simple ImageStream object looks like this:

*`imagestream.yaml`*:
```yaml
apiVersion: image.openshift.io/v1
kind: ImageStream
metadata:
  labels:
    app: serveapp
  name: serveimagestream
spec:
  lookupPolicy:
    local: false
```

## BuildConfig

A BuildConfig objects create container images according to specific rules. In the following example the Docker strategy is used to build trivial extension of `httpd` image shipped with openshift.

*`buildconfig.yaml`*:

```yaml
kind: "BuildConfig"
apiVersion: "v1"
metadata:
  name: "serveimg-generate"
  labels:
    app: "serveapp"
spec:
  runPolicy: "Serial"
  output:
    to:
      kind: ImageStreamTag
      name: serveimagestream:latest
  source:
    dockerfile: |
      FROM docker-registry.default.svc:5000/openshift/httpd
  strategy: 
    type: Docker
```

After creating the build object (here named `serveimg-generate`), we can request openshift cluster to build the image with

```bash
$ oc start-build serveimg-generate
```

Other source strategies include `custom`, `jenkins` and `source`.
