pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "test"
        DOCKER_TAG = "latest"
        DOCKER_REGISTRY = "your-docker-registry-url"
        SSH_CREDENTIALS_ID = "your-ssh-credentials-id"
        SERVER_IP = "192.168.20.2"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build') {
            steps {
                sh './gradlew build' // Replace with your build command
            }
        }

        stage('Test') {
            steps {
                sh './gradlew test' // Replace with your test command
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                    sh """
                    docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                    docker stop my-app || true
                    docker rm my-app || true
                    docker run -d --name my-app -p 80:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
