pipeline {
    agent any

    environment {
        VERSION_TAG = '1.0.0' // Переменная для хранения тега версии
    }

    stages {
        stages {
            stage('Set Version Tag') {
                steps {
                    script {
                        // Устанавливаем тег версии на основе номера сборки
                        env.VERSION_TAG = "1.0.${env.BUILD_NUMBER}" // Формируем версию
                        echo "Текущий тег версии: ${env.VERSION_TAG}"
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Строим Docker образ с тегом версии
                    def image = docker.build("test:${env.VERSION_TAG}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Запускаем Docker контейнер с указанным тегом
                    docker.image("test:${env.VERSION_TAG}").run('-p 80:80')
                }
            }
        }
    }
}
