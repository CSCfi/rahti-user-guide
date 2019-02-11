## Jobs

*Jobs* are in a sense run-to-completion Pods, except that they operate on the same level as ReplicationControllers, in a sense that they too define template for pod to be launched instead of directly describing the pod. The difference is, however, that *Jobs* are not restarted when they finish.

*`job.yaml`*:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      volumes:
      - name: smalldisk-vol
        emptyDir: {}
      containers:
      - name: pi
        image: perl
        command:
        - sh
        - -c
        - >
          echo helloing so much here! Lets hello from /mountdata/hello.txt too: &&
          echo hello to share volume too >> /mountdata/hello-main.txt &&
          cat /mountdata/hello.txt
        volumeMounts: 
        - mountPath: /mountdata
          name: smalldisk-vol
      restartPolicy: Never
      initContainers:
      - name: init-pi
        image: perl
        command: 
        - sh
        - -c
        - >
          echo this hello is from the initcontainer >> /mountdata/hello.txt
        volumeMounts: 
        - mountPath: /mountdata
          name: smalldisk-vol
  backoffLimit: 4
```

## Persistent storage

Persistent storage is requested from the cluster using `PersistentVolumeClaim` objects:

*`pvc.yaml`*

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: testing-pvc
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

Persistent storage can be requested also from GUI.

This will request a 1 GiB persistent storage that can be mounted in read-write mode by multiple nodes.

The persistent volume can be mounted to pods with `spec.volumes` and `spec.containers.volumes`:

*`pvc-pod.yaml`*:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod-vol
  labels:
    app: serveapp-vol
    pool: servepod-vol
spec:
  containers:
  - name: serve-cont
    image: "docker-registry.default.svc:5000/openshift/httpd"
    volumeMounts: 
    - mountPath: /mountdata
      name: smalldisk-vol
  volumes:
  - name: smalldisk-vol
    persistentVolumeClaim:
      claimName: testing-pvc
```

## InitContainer

*InitContainer* is a container in a pod that is run to completion before the main containers are started. Data from init containers are most easily transfered to the main container using volume mounts

*`pod-init.yaml`*:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    app: serveapp
    pool: servepod
spec:
  volumes: 
  - name: sharevol
    emptyDir: {}
  initContainers:
  - name: perlhelper
    image: perl
    command:
    - sh
    - -c
    - >
      echo Hello from perl helper > /datavol/index.html
    volumeMounts:
    - mountPath: /datavol
      name: sharevol
  containers:
  - name: serve-cont
    image: docker-registry.default.svc:5000/openshift/httpd
    volumeMounts:
    - mountPath: /var/www/html
      name: sharevol
```

Here we run init container from image perl which echoes stuff to file `index.html` on the shared volume. 

The shared volume is defined in `spec.volumes` and "mounted" in `spec.initContainers.volumeMounts` and `spec.containers.volumeMounts`.

## Jobs

*Jobs* are in a sense run-to-completion Pods, except that they operate on the same level as ReplicationControllers, in a sense that they too define template for pod to be launched instead of directly describing the pod. The difference is, however, that *Jobs* are not restarted when they finish.

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  template:
    spec:
      volumes:
      - name: smalldisk-vol
        emptyDir: {}
      containers:
      - name: pi
        image: perl
        command:
        - sh
        - -c
        - >
          echo helloing so much here! Lets hello from /mountdata/hello.txt too: &&
          echo hello to share volume too >> /mountdata/hello-main.txt &&
          cat /mountdata/hello.txt
        volumeMounts: 
        - mountPath: /mountdata
          name: smalldisk-vol
      restartPolicy: Never
      initContainers:
      - name: init-pi
        image: perl
        command: 
        - sh
        - -c
        - >
          echo this hello is from the initcontainer >> /mountdata/hello.txt
        volumeMounts: 
        - mountPath: /mountdata
          name: smalldisk-vol
  backoffLimit: 4
```

## Passing configuration data to containers: ConfigMap and Secrets

**ConfigMaps** are useful in collecting configuration-type data in Kuberentes' objects. Their contents are communicated to containers by environmental variables or by volume mounts.

*`configmap.yaml`*:

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: my-config-map
data: 
  data.prop.a: hello
  data.prop.b: bar
  data.prop.long: |-
    fo=bar
    baz=notbar
```

The following pod imports the value of `data.prop.a` to `DATA_PROP_A` environment variable and creates files `data.prop.a`, `data.prop.b` and `data.prop.long` inside `/etc/my-config`:

*`configmap-pod.yaml`*:

```yaml
kind: Pod
apiVersion: Pod
metadata:
  name: my-config-map-pod
spec:
  restartPolicy: Never
  volumes:
  - name: configmap-vol
    configMap:
      name: my-config-map
  containers:
  - name: confmap-cont
    image: perl
    command: 
    - /bin/sh
    - -c
    - |-
      cat /etc/my-config/data.prop.long &&
      echo "" &&
      echo DATA_PROP_A=$DATA_PROP_A
    env:
    - name: DATA_PROP_A
      valueFrom:
        configMapKeyRef:
          name: prop-a-config
          key: data.prop.a
          optional: true     # Run this pod even if data.prop.a is not defined in configmap
    volumeMounts:
    - name: configmap-vol
      mountPath: /etc/my-config
```

The output log, given by command `oc logs contmap-cont` of this container should be

```
fo=bar
baz=notbar
DATA_PROP_A=hello
```

**Secrets** behave much like ConfigMaps, but once created, they are stored in
base64 encoded form and their contents are not displayed by default with `oc
describe` command. There is an example of a Secret in the Webhooks section.

## Webhooks

Rahti supports Generic, GitHub, GitLab and Bitbucket webhooks. They are particularly useful in triggering builds.
The syntax for BuildConfig is as follows:

```yaml
spec:
  triggers:
  - type: GitHub
    github:
      SecretReference:
        name: webhooksecret
```

Now the Secret `webhooksecret` should have

```yaml
apiVersion: v1
kind: Secret
data:
  WebHookSecretKey: dGhpc19pc19hX2JhZF90b2tlbgo=    # "this_is_a_bad_token" in base64 encoding
metadata:
  name: webhooksecret
  namespace: mynamespace     # set this to your project namespace
```

When the BuildConfig is configured to trigger from the webhook and the corresponding secret exists, the webhook URL can be found by using (assuming we added the webhook to `serveimg-generate`) `oc describe` command:

```
$ oc describe bc/serveimg-generate
Name:		serveimg-generate
.
.
.
Webhook GitHub:
	URL:	https://rahti.csc.fi:8443/apis/build.openshift.io/v1/.../<secret>/github
.
.
.
```

Finally, the GitHub WebHook payload url is the url above with `<secret>` replaced with base64 decoded string of the value of `data.WebHookSecretKey` above and the content type is `application/json`.


