#!/usr/bin/env bash

set +x

oc project fuse7

# policy to allow jenkins user tag/pull
export JENKINS_PROJECT='fuse7'
export JENKINS_SERVICEACCOUNT='jenkins'
oc policy add-role-to-user edit system:serviceaccount:${JENKINS_PROJECT}:${JENKINS_SERVICEACCOUNT} -n fuse7

oc policy add-role-to-user edit system:serviceaccount:${JENKINS_PROJECT}:${JENKINS_SERVICEACCOUNT} -n fuse7-stage
oc policy add-role-to-user system:image-puller system:serviceaccount:fuse7-stage:default -n fuse7

oc policy add-role-to-user edit system:serviceaccount:${JENKINS_PROJECT}:${JENKINS_SERVICEACCOUNT} -n fuse7-qa
oc policy add-role-to-user system:image-puller system:serviceaccount:fuse7-qa:default -n fuse7-stage

# misc policy
oc policy add-role-to-user view -z default
oc policy add-role-to-user admin -z jenkins
#oc adm policy add-role-to-user system:registry jenkins
#oc policy add-scc-to-user -z jenkins privileged
oc adm policy add-role-to-user system:image-builder jenkins
oc adm policy add-role-to-user admin jenkins -n fuse7
oc adm policy add-role-to-user admin jenkins -n fuse7-stage

# create image stream
oc create imagestream spring-boot-simple-server
oc process -f templates/build.yml | oc apply -f -
oc process -f templates/deployment.yml | oc apply -f -

oc project fuse7-stage

# create image stream
oc create imagestream spring-boot-simple-server

oc process -f templates/build.yml | oc apply -f -
oc process -f templates/deployment.yml | oc apply -f -

# create and start pipeline
oc project fuse7
oc process -f templates/pipeline.yml | oc create -f -

