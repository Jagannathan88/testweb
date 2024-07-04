pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        REPO_URL = 'https://github.com/Jagannathan88/capstone.git'
        BRANCH = 'dev'
        DOCKER_IMAGE = 'jagannathan88/dev:latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "${env.BRANCH}", url: "${env.REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${env.DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    docker.image("${env.DOCKER_IMAGE}").run('-d -p 80:80')
                }
            }
        }
    }
}

