#!/usr/bin/env bash

oc delete all,configmap,pvc,serviceaccount,rolebinding --selector name=jenkins
oc delete all,configmap,pvc,serviceaccount,rolebinding --selector app=jenkins-persistent
