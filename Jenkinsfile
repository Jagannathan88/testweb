pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        REPO_URL = 'https://github.com/Jagannathan88/testweb.git'
        BRANCH = 'test'
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
            	    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                	docker.image('jagannathan88/dev:latest').push()
            	}
             }	
         } 

        stage('Deploy Container') {
            steps {
                script {
                    def app = docker.image("${env.DOCKER_IMAGE}")
                    app.run('-d -p 80:80')
                }
            }
        }
    }
}

