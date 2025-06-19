@Library('minhalib') _

pipeline {
  agent {
    kubernetes {
      yaml libraryResource('pod_templates/apictl-alpine.yaml')
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

    stage('Test') {
      steps {
        saudacao("Hebert")
      }
    }

    stage('Versão do apictl') {
      steps {
        echo '[APICTL] Teste de versão do apictl (simulado)...'
        sh 'apictl version'
      }
    }

    stage('Deploy') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'wso2-credential', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
          echo '[Deploy] Realizando o deploy (simulado)...'
          container('simple-agent') {
          sh '''
            apictl add env ds --apim https://apimds.k3d.local:9443
            apictl login ds -u $USERNAME -p $PASSWORD --insecure
            apictl import-api -f . --environment ds --update --preserve-provider=false --insecure
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
