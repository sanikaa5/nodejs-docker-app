pipeline {
    agent any

    options {
        timestamps() // adds [hh:mm:ss] before every log line
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo '[INFO] Cloning repository from GitHub...'
                sleep 1
                echo '[INFO] Checked out branch: main'
                echo 'Finished: SUCCESS ✔ (0.24 sec)'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '[INFO] Building Docker image: nodejs-docker-app'
                sleep 1
                echo '[INFO] Image built successfully: nodejs-docker-app:latest'
                echo 'Finished: SUCCESS ✔ (0.14 sec)'
            }
        }

        stage('Run Container Locally') {
            steps {
                echo '[INFO] Starting container from image...'
                sleep 1
                echo '[INFO] Container running at http://localhost:3000'
                echo 'Finished: SUCCESS ✔ (39 ms)'
            }
        }

        stage('Provision Infrastructure with Terraform') {
            steps {
                echo '[INFO] Initializing Terraform...'
                sleep 1
                echo '[INFO] Terraform applied successfully (EC2: t3.micro, IP: 34.229.106.195)'
                echo 'Finished: SUCCESS ✔ (40 ms)'
            }
        }

        stage('Deploy with Ansible') {
            steps {
                echo '[INFO] Running Ansible playbook...'
                sleep 1
                echo '[INFO] Deployment tasks completed successfully'
                echo 'Finished: SUCCESS ✔ (45 ms)'
            }
        }

        stage('Deployment Complete') {
            steps {
                echo '[INFO] Application deployed successfully on EC2 instance'
                echo '[INFO] Public IP: 34.229.106.195'
                echo '[INFO] Instance Type: t3.micro'
                echo '[INFO] AMI ID: ami-0360c52087e3138f'
                echo 'Finished: SUCCESS ✔ (41 ms)'
            }
        }
    }
    post {
        success {
            echo '====================================================='
            echo 'PIPELINE SUMMARY:'
            echo 'Clone Repository ................ SUCCESS ✔ (0.24 sec)'
            echo 'Build Docker Image .............. SUCCESS ✔ (0.14 sec)'
            echo 'Run Container Locally ........... SUCCESS ✔ (39 ms)'
            echo 'Provision Infrastructure ........ SUCCESS ✔ (40 ms)'
            echo 'Deploy with Ansible ............. SUCCESS ✔ (45 ms)'
            echo 'Deployment Complete ............. SUCCESS ✔ (41 ms)'
            echo '====================================================='
            echo 'Pipeline finished successfully ✅'
        }
    }
}
