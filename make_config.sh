#!/bin/sh

set -e
: ${CLUSTER_LANDING_PAGE_ENV_VERSION?"Must set CLUSTER_LANDING_PAGE_ENV_VERSION"}
: ${CLUSTER_LOGIN_URL_OIDCIDP?"Must set CLUSTER_LOGIN_URL_OIDCIDP"}
: ${CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION?"Must set CLUSTER_LANDING_PAGE_SECONDARY_ENV_VERSION"}

mkdir -p /usr/share/nginx/html/agreements/terms_of_use/

yasha -o /usr/share/nginx/html/index.html index.html.j2
yasha -o /usr/share/nginx/html/agreements/terms_of_use/terms_of_use.html terms_of_use.html.j2
