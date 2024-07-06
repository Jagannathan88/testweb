pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'  // Update with your Docker Hub credentials ID
        REPO_URL = 'https://github.com/Jagannathan88/testweb.git'
        BRANCH = 'test'
        DOCKER_IMAGE = 'jagannathan88/dev:latest'
        CONTAINER_NAME = 'my-app-container'
    }

    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                git branch: "${env.BRANCH}", url: "${env.REPO_URL}"
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${env.DOCKER_HUB_CREDENTIALS}") {
                        def dockerImage = docker.build("${env.DOCKER_IMAGE}")
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop and remove the container if it exists
                    sh "docker ps -aqf name=${env.CONTAINER_NAME} | xargs -r docker stop"
                    sh "docker ps -aqf name=${env.CONTAINER_NAME} | xargs -r docker rm"

                    // Run the new container
                    sh "docker run -d -p 80:80 --name ${env.CONTAINER_NAME} ${env.DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            script {
                docker.withRegistry('', "${env.DOCKER_HUB_CREDENTIALS}") {
                    docker.image("${env.DOCKER_IMAGE}").stop()
                    docker.image("${env.DOCKER_IMAGE}").remove()
                }
                sh "docker stop ${env.CONTAINER_NAME} || true"
                sh "docker rm ${env.CONTAINER_NAME} || true"
            }
        }
    }
}

