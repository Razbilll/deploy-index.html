pipeline {
    agent any

    stages {
        stage('Build Docker Image ') {
            steps {
                script {
                    def image = docker.build("test:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Запускаем Docker контейнер на порту 80
                    docker.image("test:${env.BUILD_NUMBER}").run('-p 80:80')
                }
            }
        }
    }
}
