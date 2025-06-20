@Library('minhalib') _

pipeline {
  agent {
    kubernetes {
      yaml libraryResource('pod_templates/apictl-ubi9.yaml')
      defaultContainer 'simple-agent'
    }
  }

  environment {
    DEST_HOST = '192.168.1.5'
  }

  stages {
    stage('Checkout') {
      steps {
        echo '[Checkout] Clonando o repositório (simulado)...'
        git url: 'https://github.com/hebertmm/teste.git',
                    branch: 'main'
      }
    }

    stage('Validação com redocly') {
      steps {
        container('redocly') {
          sh 'redocly lint Definitions/swagger.yaml --extends minimal --format checkstyle > redocly-checkstyle.xml || true'
        }
      }
    }

    stage('Build ') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'wso2-credential', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
          container('simple-agent') {
          sh '''
            apictl add env ds --apim https://apimds.k3d.local:9443 --insecure
            echo $PASSWORD | apictl login ds -u $USERNAME --password-stdin  --insecure
            apictl bundle --source .
          '''
        } 
        }
      }
    }

    stage('Deploy') {
      steps {
        echo '[Deploy] Realizando o deploy no artifactory...'
        withCredentials([usernamePassword(credentialsId: 'artifactory-credential', passwordVariable: 'ARTIFACTORY_PASSWORD', usernameVariable: 'ARTIFACTORY_USERNAME')]) {
          container('simple-agent') {
            sh '''
              echo ls *.zip
            '''
          }
        }
      }
    }
  }

  post {
    success {
      echo '[Pipeline] Finalizado com sucesso!'
    }
    failure {
      echo '[Pipeline] Falha na execução!'
    }
    always {
      echo '[Pipeline] Etapa pós-execução.'
      recordIssues tools: [checkStyle(pattern: 'redocly-checkstyle.xml')]
    }
  }
}
