### spring-boot-simple-server

Create pipeline using Jenkinsfile
```
./setup.sh
```

#####URL

```
curl -s http://$(oc get route spring-boot-simple-server --template='{{ .spec.host }}')/helloUser
```

Cleanup

```
./cleanup.sh
```

Cleanup Jenkins

```
./clenup-jenkins.sh
```

##### Declarative pipelines
https://developers.redhat.com/blog/2017/11/20/building-declarative-pipelines-openshift-dsl-plugin/


##### Login with Jenkins user
```
oc sa get-token jenkins  
oc login --token=
whoami
```

