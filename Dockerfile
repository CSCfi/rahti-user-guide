FROM almalinux:8

LABEL maintainer="CSC Rahti Team <rahti-team@postit.csc.fi>"

ARG CLUSTER_LANDING_PAGE_ENV_VERSION
ARG CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION
ARG CLUSTER_LOGIN_URL_OIDCIDP

ENV LANG=en_US.UTF-8
ENV CLUSTER_LANDING_PAGE_ENV_VERSION=${CLUSTER_LANDING_PAGE_ENV_VERSION}
ENV CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION=${CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION}
ENV CLUSTER_LOGIN_URL_OIDCIDP=${CLUSTER_LOGIN_URL_OIDCIDP}

# These need to be owned and writable by the root group in OpenShift
ENV ROOT_GROUP_DIRS='/var/run /var/log/nginx /var/lib/nginx'

RUN yum -y install epel-release &&\
    yum -y install nginx python3-pip python3 &&\
    yum clean all &&\
    chmod g+rwx /var/run /var/log/nginx

RUN chgrp -R root ${ROOT_GROUP_DIRS} &&\
    chmod -R g+rwx ${ROOT_GROUP_DIRS}

COPY ./static /usr/share/nginx/html/static
COPY ./index.html.j2 /tmp
COPY ./make_config.sh /tmp
COPY ./requirements.txt /tmp

WORKDIR /tmp

RUN pip3 install --no-cache-dir -r requirements.txt && \
    sh -c /tmp/make_config.sh

COPY nginx.conf /etc/nginx

EXPOSE 8000

CMD [ "/usr/sbin/nginx" ]
