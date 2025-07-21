pipeline {
  agent { label 'jenkins-agent' }
  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/Pavlo-1992/forStep2-node-app.git', branch: 'main'
      }
    }
    stage('Build Docker image') {
      steps {
        script {
          dockerImage = docker.build("forstep2-app:${env.BUILD_NUMBER}")
        }
      }
    }
    stage('Run tests') {
      steps {
        script {
          def testResult = dockerImage.inside {
            sh 'npm install'
            sh 'npm test'
          }
          if (currentBuild.result == 'FAILURE') {
            error "Tests failed!!!"
          }
        }
      }
    }
    stage('Push to Docker Hub') {
      when { expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' } }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          script {
            sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
            dockerImage.push("${env.BUILD_NUMBER}")
          }
        }
      }
    }
  }
}
