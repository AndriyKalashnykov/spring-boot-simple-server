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
oc create -f templates/is.yml
#oc create imagestream spring-boot-simple-server

oc process -f templates/build.yml | oc apply -f -
oc process -f templates/deployment.yml | oc apply -f -

oc project fuse7-stage

# create image stream
oc create -f templates/is.yml
#oc create imagestream spring-boot-simple-server
#oc create -f templates/is.jenkins.maven.yml

oc process -f templates/build.yml | oc apply -f -
oc process -f templates/deployment.yml | oc apply -f -

oc project fuse7

# Create ACME Controller (Supports e.g. Let's Encrypt)
#oc create -fhttps://raw.githubusercontent.com/tnozicka/openshift-acme/master/deploy/letsencrypt-live/single-namespace/{role,serviceaccount,imagestream,deployment}.yaml
oc create -ftemplates/openshift-acme/deploy/letsencrypt-live/single-namespace/{role,serviceaccount,imagestream,deployment}.yaml
oc policy add-role-to-user openshift-acme --role-namespace="$(oc project --short)" -z openshift-acme

# Create HTTPS route
oc create route edge https-spring-boot-simple-server --service=spring-boot-simple-server
oc patch route https-spring-boot-simple-server -p '{"metadata":{"annotations":{"kubernetes.io/tls-acme":"true"}}}'


# create and start pipeline
oc process -f templates/pipeline.yml | oc create -f -
#oc process -f https://raw.githubusercontent.com/AndriyKalashnykov/spring-boot-simple-server/master/templates/pipeline.yml | oc create -f -


