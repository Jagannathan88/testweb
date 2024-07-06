pipeline {
    agent any

    environment {
        registryCredential = 'docker-hub-credentials'
        dockerImage = 'jagannathan88/dev:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/test']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/Jagannathan88/testweb.git']]])
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
                // Add your deployment steps here
                // This stage will be executed after successful build and push
            }
        }
    }

    post {
        always {
            script {
                // Clean up steps or any post-processing logic
                docker.withRegistry('', registryCredential) {
                    def customImage = docker.image(dockerImage)
                    customImage.remove()
                }
            }
        }
    }
}

