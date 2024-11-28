
pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def image = docker.build("test")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    docker.run("test", "-p 80:80") 
                }
            }
        }
    }
}
