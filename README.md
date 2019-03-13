### spring-boot-simple-server

Create pipeline using Jenkinsfile
```
oc project fuse7
oc process -f https://raw.githubusercontent.com/AndriyKalashnykov/spring-boot-simple-server/master/templates/pipeline.yml | oc create -f -
```

#####URL

```
curl -s http://$(oc get route spring-boot-simple-server --template='{{ .spec.host }}')/helloUser
```

Cleanup

```
./cleanup.sh
```

##### Declarative pipelines
https://developers.redhat.com/blog/2017/11/20/building-declarative-pipelines-openshift-dsl-plugin/


##### Login with Jenkins user
```
oc sa get-token jenkins  
oc login --token=
whoami
```

