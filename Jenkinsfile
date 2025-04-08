pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {
        stage('Build') {
          agent {
            label 'test-environment'
          }
          steps {
            echo '🔨 Build Stage - develop branch'
            git(branch: 'develop', url: 'https://github.com/Saivani-Mehatha/DevOps-CICD-Jenkins.git')
            sh '''
                    docker rm -f c1 || true
                    docker build -t job1_build docker/
                    docker run -itd -p 83:80 --name c1 job1_build
                '''
          }
        }

        stage('Build Stage') {
          steps {
            sh '''git clone -b develop https://github.com/Saivani-Mehatha/DevOps-CICD-Jenkins.git
cd DevOps-CICD-Jenkins/docker/
docker rm -f c1 || true
docker build -t job1_build .
docker run -itd -p 83:80 --name c1 job1_build

'''
          }
        }

      }
    }

    stage('Test') {
      parallel {
        stage('Test') {
          agent {
            label 'test-environment'
          }
          steps {
            echo '🧪 Test Stage - master branch'
            git(branch: 'master', url: 'https://github.com/Saivani-Mehatha/DevOps-CICD-Jenkins.git')
            sh '''
                    docker rm -f c2 || true
                    docker build -t job2_test docker/
                    docker run -itd -p 82:80 --name c2 job2_test
                '''
          }
        }

        stage('Test Stage') {
          steps {
            sh '''git clone -b master https://github.com/Saivani-Mehatha/DevOps-CICD-Jenkins.git
cd DevOps-CICD-Jenkins/docker/
docker rm -f c2 || true
docker build -t job2_test .
docker run -itd -p 82:80 --name c2 job2_test
'''
          }
        }

      }
    }

    stage('Deploy') {
      parallel {
        stage('Deploy') {
          agent {
            label 'prod-environment'
          }
          steps {
            echo '🚀 Deploy Stage - master branch'
            git(branch: 'master', url: 'https://github.com/Saivani-Mehatha/DevOps-CICD-Jenkins.git')
            sh '''
                    docker rm -f c3 || true
                    docker build -t job3_prod docker/
                    docker run -itd -p 81:80 --name c3 job3_prod
                '''
          }
        }

        stage('Deploy Stage') {
          steps {
            sh '''git clone -b master https://github.com/Saivani-Mehatha/DevOps-CICD-Jenkins.git
cd DevOps-CICD-Jenkins/docker/
docker rm -f c3 || true
docker build -t job3_prod .
docker run -itd -p 81:80 --name c3 job3_prod
'''
          }
        }

      }
    }

  }
  post {
    success {
      echo '✅ Pipeline completed successfully!'
    }

    failure {
      echo '❌ Pipeline failed. Check logs.'
    }

  }
}