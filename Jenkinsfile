
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
                    docker.image('test').run('-p 80:80')
                }
            }
        }
    }
}
