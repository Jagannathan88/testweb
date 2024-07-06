pipeline {
    agent any

    environment {
        registryCredential = 'docker-hub-credentials'
        dockerImage = 'jagannathan88/dev:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/test']], userRemoteConfigs: [[url: 'https://github.com/Jagannathan88/testweb.git']]])
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', registryCredential) {
                        def customImage = docker.build(dockerImage)
                        customImage.push()
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                // Add deployment steps here, e.g., deploying to Kubernetes, Docker Swarm, etc.
            }
        }
    }

    post {
        always {
            script {
                docker.withRegistry('', registryCredential) {
                    def customImage = docker.image(dockerImage)
                    customImage.remove()
                }
            }
        }
    }
}

