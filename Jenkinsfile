pipeline {

    environment {
        dockerimg=''
        registryCredentials = credentials('dockerhub')
    }

    agent any

    stages {
        stage('Step 1: Git Clone') {
            steps {
                git 'https://github.com/gaurangi99/SPE_MiniProject'
            }
        }

        stage('Step 2: Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Step 3: Build Docker Image ') {
            steps {
                script{
                    dockerimg=docker.build("gaurangi99/spe-mini-project:${BUILD_NUMBER}")
                }
            }
        }

        stage('Step 4: Push Docker Image')
        {
            steps {
                script{
                    sh 'echo $registryCredentials_PSW | docker login -u $registryCredentials_USR --password-stdin'
                    docker.withRegistry('', 'dockerhub'){
                    dockerimg.push()
                    }
                }
            }
        }

        stage('Step 5: Removing Docker Image from Local') {
            steps {
                sh "docker rmi gaurangi99/spe-mini-project:${BUILD_NUMBER}"
                sh "docker stop calculator"
                sh "docker rm calculator"
            }
        }

        stage('Step 6: Ansible'){
            steps{
                ansiblePlaybook becomeUser: null,
                colorized: true,
                disableHostKeyChecking: true,
                installation: 'Ansible',
                inventory: 'inventory',
                playbook: 'playbook.yml',
                sudoUser: null
            }
        }
    }
}
