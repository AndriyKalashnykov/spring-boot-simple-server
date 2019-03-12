#!/usr/bin/env bash

oc project fuse7
oc delete all -l application=spring-boot-simple-server

oc project fuse7-stage
oc delete all -l application=spring-boot-simple-server

