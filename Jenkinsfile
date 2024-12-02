pipeline {
    agent any

    stages {
        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Вычисляем тег на 1 меньше
                    def previousBuildNumber = env.BUILD_NUMBER.toInteger() - 1
                    def previousTag = "test:1.0.${previousBuildNumber}" // Формируем тег
        
                    // Получаем ID контейнера по тегу образа
                    def containerId = sh(script: "docker ps -q --filter 'ancestor=${previousTag}'", returnStdout: true).trim()
                    
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
