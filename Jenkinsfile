pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'        
        ECR_REPOSITORY = 'dev/assingement' 
        IMAGE_TAG = "$(BUILD_NUMBER)"    
        AWS_ACCOUNT_ID = '314146334258' 
        DOCKER_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
        DEPLOY_HOST = 'user@docker-server'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sudheer76R/java-example.git'
            }
        }

        stage('Build Stage') {
           steps {
            echo "Building the docker image"
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Push to ECR') {
            step {          
                    sh """
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    """
                    sh "docker push ${DOCKER_IMAGE}"
            }
        }

        stage('Depoly Stage') {
            steps {
                    sh """
                        ssh -o StrictHostKeyChecking=no user@docker-server << 'EOF'
                            docker pull ${DOCKER_IMAGE} || exit 1
                            docker stop my_container || true
                            docker rm my_container || true
                            docker run -d --name my_container ${DOCKER_IMAGE} || exit 1
                        EOF
                    """
               }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

