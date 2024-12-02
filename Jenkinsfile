pipeline {
    agent any

    stages {
        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Останавливаем и удаляем существующий контейнер, если он запущен
                    def containerName = "test:1.0.${env.BUILD_NUMBER - 1}" // Имя контейнера
                    try {
                        // Останавливаем контейнер
                        sh "docker stop ${containerName} || true"
                        // Удаляем контейнер
                        sh "docker rm ${containerName} || true"
                    } catch (Exception e) {
                        echo "Контейнер не найден или не может быть остановлен/удален: ${e}"
                    }
                }
            }
        }
        stage('Build Docker Image ') {
            steps {
                script {
                    def image = docker.build("test:1.0.${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Запускаем Docker контейнер на порту 80
                    docker.image("test:1.0.${env.BUILD_NUMBER}").run('-p 80:80')
                }
            }
        }
    }
}
