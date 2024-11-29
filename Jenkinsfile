pipeline {
    agent any

    environment {
        VERSION_TAG = '' // Переменная для хранения тега версии
    }

    stages {
        stage('Get Running Builds') {
            steps {
                script {
                    // Получаем количество запущенных пайплайнов
                    def builds = Jenkins.instance.getItemByFullName(env.JOB_NAME).builds
                    def runningBuilds = builds.count { it.isBuilding() }
                    echo "Количество запущенных пайплайнов: ${runningBuilds}"

                    // Определяем версию на основе количества запущенных пайплайнов
                    def version = "1.0.${runningBuilds + 1}" // Увеличиваем версию
                    env.VERSION_TAG = version
                    echo "Текущий тег версии: ${env.VERSION_TAG}"
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

        stage('Tag Version') {
            steps {
                script {
                    // Проверяем, существует ли тег
                    def tagExists = sh(script: "git tag -l | grep -w ${env.VERSION_TAG}", returnStatus: true) == 0
                    if (!tagExists) {
                    // Добавление тега в Git (если необходимо)
                        sh "git tag -a ${env.VERSION_TAG} -m 'Release version ${env.VERSION_TAG}'"
                        sh "git push origin ${env.VERSION_TAG}"
                    } else {
                        echo "Тег ${env.VERSION_TAG} уже существует. Пропускаем создание тега."
                    }
                }
            }
        }
    }
}
