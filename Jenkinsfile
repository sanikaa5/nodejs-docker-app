pipeline {
    agent any

    environment {
        IMAGE_NAME = "sanikaa5/node-app:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', url: 'https://github.com/sanikaa5/nodejs-docker-app.git'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                sh 'chmod +x scripts/build_and_push.sh'
                sh './scripts/build_and_push.sh'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('infra') {
                    sh '''
                    terraform init
                    terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                sh 'ansible-playbook -i ansible/hosts.ini ansible/deploy.yml'
            }
        }
    }
}
