# spring-boot-simple-server


Create configs and deploy app
```
oc process -f https://raw.githubusercontent.com/AndriyKalashnykov/spring-boot-simple-server/master/templates/pipeline.yml | oc create -f -

oc process -f https://raw.githubusercontent.com/AndriyKalashnykov/spring-boot-simple-server/master/templates/build.yml | oc create -f -
oc process -f https://raw.githubusercontent.com/AndriyKalashnykov/spring-boot-simple-server/master/templates/deployment.yml | oc create -f -
```


To cleanup
```
oc delete all -l application=spring-boot-simple-server
```


#Declarative pipelines

https://developers.redhat.com/blog/2017/11/20/building-declarative-pipelines-openshift-dsl-plugin/