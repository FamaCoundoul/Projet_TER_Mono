pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'jdk17'
    }

    environment {
        // Pas d’interpolation directe dans `sh`, on utilise des variables dans le shell lui-même
        SONAR_URL = 'http://sonarqube:9000'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/FamaCoundoul/Projet_TER_Mono.git',
                    credentialsId: 'ID-Github'
            }
        }

        stage('Build') {
            steps {
                dir('backend-mono/E-Commerce') {
                    sh 'mvn clean install'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                dir('backend-mono/E-Commerce') {
                    withSonarQubeEnv('SonarQubeConnection') {
                        withCredentials([string(credentialsId: 'ID-Sonarqube', variable: 'SONAR_TOKEN')]) {
                            sh '''
                                mvn sonar:sonar \
                                -Dsonar.projectKey=backend-mono \
                                -Dsonar.projectName="Backend Mono" \
                                -Dsonar.host.url=${SONAR_URL} \
                                -Dsonar.login=${SONAR_TOKEN}
                            '''
                        }
                    }
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Échec du pipeline.'
        }
        success {
            echo '✅ Pipeline exécuté avec succès !'
        }
    }
}
