pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'jdk17'
    }

    environment {
        SONAR_TOKEN = credentials('ID-Sonarqube') // ID du token dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/FamaCoundoul/Projet_TER_Mono.git',
                    credentialsId: 'ID-Github' // ← ton ID GitHub Jenkins ici
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
                        sh """
                            mvn sonar:sonar \
                            -Dsonar.projectKey=backend-mono \
                            -Dsonar.projectName=Backend Mono \
                            -Dsonar.host.url=http://sonarqube:9000 \
                            -Dsonar.login=$SONAR_TOKEN
                        """
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
