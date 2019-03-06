// Load openshift-pipeline Shared Library
library identifier: 'openshift-pipeline@master', retriever: modernSCM([$class: 'GitSCMSource',
   remote: 'https://github.com/domenicbove/openshift-pipeline.git']) _

mainPipeline {
    gitRepoUrl = "https://github.com/AndriyKalashnykov/spring-boot-simple-server"
    microservice = "spring-boot-simple-server"
    templateGitRepoUrl = "https://github.com/domenicbove/openshift-templates.git"
    templateGitTag = "master"
    ocpUrl = "master1.fismobile.net"
    buildProject = "demo-build"
    testProject = "demo-test"
    prodProject = "demo-prod"
}
