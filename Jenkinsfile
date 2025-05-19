pipeline {
    agent any

    tools {
        nodejs "Node18" // configuré dans Jenkins > Global Tool Configuration
        maven "Maven3"  // idem
    }

    environment {
        SONARQUBE = 'SonarQubeServer' // Nom configuré dans Jenkins > SonarQube config
        SONAR_TOKEN = credentials('116540dd-2483-4126-89ad-c1c8a39d0b82') // Stocké dans Jenkins Credentials
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/FamaCoundoul/Projet_TER_Mono.git', branch: 'master'
            }
        }

        stage('Build Backend') {
            dir('backend-mono/E-Commerce') {
                steps {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Analyze Backend with SonarQube') {
            dir('backend-mono/E-Commerce') {
                steps {
                    withSonarQubeEnv("${SONARQUBE}") {
                        sh "mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}"
                    }
                }
            }
        }

        stage('Build Frontend') {
            dir('frontend-mono/E-commerce-web') {
                steps {
                    sh 'npm install'
                    sh 'npm run build -- --configuration production'
                }
            }
        }

        stage('Analyze Frontend with SonarQube') {
            dir('frontend-mono/E-commerce-web') {
                steps {
                    withSonarQubeEnv("${SONARQUBE}") {
                        sh "sonar-scanner -Dsonar.login=${SONAR_TOKEN}"
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }

        stage('Deploy (optional)') {
            steps {
                echo 'Deploy step can be defined here.'
            }
        }
    }
}
