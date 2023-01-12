node{ def MavenHome = tool name: 'Maven3.8.6'
    stage('clonecode'){
        git "https://github.com/Olubusuyi/tesla-app.git"
    }
    stage('test&build'){ 
        sh " ${MavenHome}/bin/mvn clean package"
    }
    stage('CodeQaulitytest'){ 
        sh " ${MavenHome}/bin/mvn sonar:sonar"
    }
    stage('deployartifacts'){ 
        sh " ${MavenHome}/bin/mvn deploy"
    }
    stage('deploytoUAT'){ 
        sh "echo 'deploy to UAT'  "
       deploy adapters: [tomcat9(credentialsId: 'tomcatcredaABC', path: '', url: 'http://54.177.121.14:8080/')], contextPath: null, war: 'target/*war'
    }
    stage('approvalgate'){
        sh "echo 'ready for prod' "
        timeout(time:1, unit:"MINUTES"){
        input message: 'Application ready for deployment,please review and approve'}
    }
    stage('deploy'){
        deploy adapters: [tomcat9(credentialsId: 'tomcatcredaABC', path: '', url: 'http://54.177.121.14:8080/')], contextPath: null, war: 'target/*war'
    }
    stage('emailnotification'){
           emailext body: '''Dear All,

           Check Build Status

          Glo''', recipientProviders: [requestor()], subject: 'Build Status', to: 'busuyiolofin@gmail.com'   
    }
}
