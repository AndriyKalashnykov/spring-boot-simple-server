#!/usr/bin/env bash

set +x

oc project fuse7

oc policy add-role-to-user view -z default
oc policy add-role-to-user admin -z jenkins

oc create imagestream spring-boot-simple-server

oc project fuse7-stage
oc create imagestream spring-boot-simple-server

oc project fuse7
oc process -f templates/build.yml | oc apply -f -
oc process -f templates/deployment.yml | oc apply -f -

oc project fuse7-stage
oc process -f templates/build.yml | oc apply -f -
oc process -f templates/deployment.yml | oc apply -f -

oc project fuse7
oc process -f templates/pipeline.yml | oc create -f -

