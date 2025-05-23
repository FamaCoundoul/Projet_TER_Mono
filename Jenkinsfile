pipeline {
    agent any

    tools {
        maven 'Maven3'              // Défini dans Jenkins > Global Tool Configuration
        jdk 'jdk17'                 // Assure-toi que tu as défini Java 17
    }

    environment {
        SONARQUBE = 'SonarQube'     // Nom défini dans Jenkins config
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/FamaCoundoul/Projet_TER_Mono.git'
            }
        }

        stage('Build') {
            steps {
                dir('backend-mono/E-Commerce') {
                    sh 'mvn clean install -DskipTests'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${env.SONARQUBE}") {
                    dir('backend-mono/E-Commerce') {
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                dir('backend-mono/E-Commerce') {
                    sh 'mvn test'
                }
            }
        }

        stage('Package') {
            steps {
                dir('backend-mono/E-Commerce') {
                    sh 'mvn package -DskipTests'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build et analyse Sonar réussis !'
        }
        failure {
            echo '❌ Échec du pipeline.'
        }
    }
}