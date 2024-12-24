pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY = 'dev/assingement'
        IMAGE_TAG = "${BUILD_NUMBER}"
        AWS_ACCOUNT_ID = '314146334258'
        DOCKER_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
        DEPLOY_HOST = 'ubuntu@172.31.42.247'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                     sh git clone https://github.com/Shekharbabun/Question5.git
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com'
                    
                    sh 'docker tag ${DOCKER_IMAGE} ${DOCKER_IMAGE}'
                    
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }

        stage('Deploy to Docker Server') {
            steps {
                script {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${DEPLOY_HOST} <<EOF
                    docker pull ${DOCKER_IMAGE}
                    docker run -d --name warfile ${DOCKER_IMAGE}
                    EOF
                    """
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}


