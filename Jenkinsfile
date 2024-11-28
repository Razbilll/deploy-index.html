@NonCPS
def myMethod() {
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
                        // Запуск контейнера
                        docker.run("test", "-p 8080:80")
                    }
                }
            }
        }
    }
}
