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
        withCredentials([sshUserPrivateKey(credentialsId: 'winserver_user_ssh', keyFileVariable: 'SSH_KEY', usernameVariable: 'USERNAME')]) {
          echo '[Deploy] Realizando o deploy (simulado)...'
          // sh '''
          //   ssh -i $SSH_KEY -o StrictHostKeyChecking=no $USERNAME@$DEST_HOST "dir C: || dir /c/temp"
          // '''  
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
