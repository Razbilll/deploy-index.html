pipeline {
    agent any

    stages {
        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Получаем ID контейнера по тегу образа
                    def containerId = sh(script: "docker ps -q --filter 'ancestor=test:1.0.${env.BUILD_NUMBER - '1'}'", returnStdout: true).trim()
                    
                    if (containerId) {
                        try {
                            // Останавливаем контейнер
                            sh "docker stop ${containerId} || true"
                            // Удаляем контейнер
                            sh "docker rm ${containerId} || true"
                        } catch (Exception e) {
                            echo "Ошибка при остановке или удалении контейнера: ${e}"
                        }
                    } else {
                        echo "Контейнер с указанным тегом не найден."
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
