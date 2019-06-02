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
./cleanup-jenkins.sh
```

##### Declarative pipelines
https://developers.redhat.com/blog/2017/11/20/building-declarative-pipelines-openshift-dsl-plugin/


##### Login with Jenkins user
```
oc sa get-token jenkins  
oc login --token=
whoami
```


##### Create SSL route using ACME Controller (via Let's Encrypt)
https://github.com/tnozicka/openshift-acme#deploy
https://asciinema.org/a/175706


oc logs -f deployment.apps/openshift-acme

###### Test application
oc create -fhttps://raw.githubusercontent.com/tnozicka/gohellouniverse/master/deploy/{deployment,service}.yaml    
oc create route edge gohellouniverse  --service=gohellouniverse
oc patch route gohellouniverse -p '{"metadata":{"annotations":{"kubernetes.io/tls-acme":"true"}}}'

curl https://gohellouniverse-fuse7.6923.rh-us-east-1.openshiftapps.com -k
oc get events -w


##### Using Letsencrypt wildcard certs with OpenShift - https://martinmurphy.tech/2018/07/using-letsencrypt-wildcard-certs-with-openshift/

0) Open https://console.aws.amazon.com/route53/home
1) Create "Hosted Zone": spring-boot-simple-server-fuse7.6923.rh-us-east-1.openshiftapps.com
2) Create "Record Set": _acme-challenge. of TXT type

3) Run docker below, then two times use change Value to what docker tells you too, before hitting enter use "Test Record Set" button to make sure that Value is updates
# docker run -it --rm --name certbot -v "/tmp/etc_letsencrypt:/etc/letsencrypt" -v "/tmp/var_lib_letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly --manual --preferred-challenges dns -d *.spring-boot-simple-server-fuse7.6923.rh-us-east-1.openshiftapps.com -d spring-boot-simple-server-fuse7.6923.rh-us-east-1.openshiftapps.com
