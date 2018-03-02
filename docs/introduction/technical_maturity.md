## Technical maturity

The \env{SYSTEM_NAME} container cloud is currently in **beta**. This page lists various
aspects of the technical maturity of the system to give you an idea of what
kinds of workloads it is suitable for at the moment.

!!! note
    OpenShift relases are based on Kubernetes versions so that OpenShift 3.6 is
    based on Kubernetes 1.6, OpenShift 3.7 is based on Kubernetes 1.7 and so on.

| Maturity indicator          | Current value                                       | Best feasible value                                              |
|-----------------------------|-----------------------------------------------------|------------------------------------------------------------------|
| **OpenShift version**       | {: class='td_ok'}\env{OPENSHIFT_VERSION}            | 3.7{: class='td_ok'}                                             |
| **Service level**           | Best effort (no formal SLA){: class='td_warn'}      | JHS174 level B (99%, service times 7-19){: class='td_ok'}        |
| **GlusterFS storage class** | Technical preview{: class='td_warn'}                | Technical preview{: class='td_warn'}                             |
