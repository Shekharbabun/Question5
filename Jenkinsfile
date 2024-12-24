pipeline {
    agent any
     environment {
        registry = '314146334258.dkr.ecr.us-east-1.amazonaws.com/dev/assingement'
    }
   
    stages {
          stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Shekharbabun/Question5.git']])
            }
        }
    stage('Building image') {
             steps{
                  script {
                   dockerImage = docker.build registry
                   }
             }
       }
    }
}
