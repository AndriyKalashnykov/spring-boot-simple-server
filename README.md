### spring-boot-simple-server

Create pipeline using Jenkinsfile
```
oc process -f https://raw.githubusercontent.com/AndriyKalashnykov/spring-boot-simple-server/master/templates/pipeline.yml | oc create -f -
```

Steps performed by Jenkinsfile pipeline
```
oc create imagestream spring-boot-simple-server
oc process -f templates/build.yml | oc create -f -
oc process -f templates/deployment.yml | oc create -f -
```

#####URL

```
curl -s http://$(oc get route spring-boot-simple-server --template='{{ .spec.host }}')/helloUser
```

Cleanup
```
oc delete all -l application=spring-boot-simple-server
```

##### Declarative pipelines
https://developers.redhat.com/blog/2017/11/20/building-declarative-pipelines-openshift-dsl-plugin/
