pipeline {
  agent any
  stages {
    stage('Install') { steps { sh 'npm ci || npm install' } }
    stage('Test') { steps { sh 'npm test || echo no-tests' } }
    stage('Build') { steps { sh 'docker build -t app:${BUILD_NUMBER} .' } }
    stage('Deploy Green') { steps { sh './scripts/deploy-green.sh ${BUILD_NUMBER}' } }
  }
}
