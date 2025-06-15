@Library('minhalib') _

pipeline {
  agent {
    kubernetes {
      yamlFile 'pod-template.yaml'
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
        git url: 'https://github.com/hebertmm/appnovo.git',
                    branch: 'main'
      }
    }

    stage('Build') {
      steps {
        echo '[Build] Compilando a aplicação (simulado)...'
        sh 'ls -la'
        sh 'cat README.md || echo "Arquivo README.md não encontrado"'
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
          sh '''
            ssh -i $SSH_KEY -o StrictHostKeyChecking=no $USERNAME@$DEST_HOST "dir C:\\\\temp || dir /c/temp"
          '''  
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
    }
  }
}
