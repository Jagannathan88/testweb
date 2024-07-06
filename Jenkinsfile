pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') // Assuming credentials are set in Jenkins
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
                    docker.build("${env.DOCKER_IMAGE}")
                    docker.withRegistry('', "${env.DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${env.DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh "docker stop ${env.CONTAINER_NAME} || true"
                    sh "docker rm ${env.CONTAINER_NAME} || true"
                    sh "docker run -d -p 80:80 --name ${env.CONTAINER_NAME} ${env.DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            script {
                docker.withRegistry('', "${env.DOCKER_HUB_CREDENTIALS}") {
                    docker.image("${env.DOCKER_IMAGE}").remove()
                }
                sh "docker stop ${env.CONTAINER_NAME} || true"
                sh "docker rm ${env.CONTAINER_NAME} || true"
            }
        }
    }
}

