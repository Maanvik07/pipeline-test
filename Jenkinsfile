pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "maanvik07/test"          // Your Docker image name from Docker Hub
        DOCKER_TAG = "latest"                    // Tag for the Docker image (you can also use a specific version or commit hash)
        DOCKER_REGISTRY = "hub.docker.com"       // Docker registry URL
        SSH_CREDENTIALS_ID = "20"  // Jenkins credentials ID for SSH
	SSH_CREDENTIALS_ID_ = "40"  // The ID of the SSH key you just created
        SERVER_IP = "192.168.20.2"               // IP address of your web server
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Maanvik07/pipeline-test.git'  // Replace with your Git repository URL
            }
        }

        stage('Build') {
            steps {
                sh './gradlew build' // Replace with your build command (e.g., npm install, mvn package, etc.)
            }
        }

       stage('Test') {
    steps {
        sh '''
            python3 -m venv venv
            source venv/bin/activate
            pip install -r requirements.txt
            pytest test_file.py  # Replace 'test_file.py' with your actual test file or directory
            deactivate
        '''
    }
}

        stage('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('', '30') {
                        def image = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                        image.push()
                    }
                }
            }
        }

       stage('Deploy to Server') {
    	steps {
        	sshagent(credentials: [SSH_CREDENTIALS_ID_]) {
           		 sh """
            	ssh maanvik@${SERVER_IP} << EOF
                docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                docker stop my-app || true
                docker rm my-app || true
                docker run -d --name my-app -p 80:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
            EOF
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
