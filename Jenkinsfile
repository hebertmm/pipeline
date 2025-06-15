@Library('minhalib') _

pipeline {
  agent {
    kubernetes {
      yamlFile 'pod-template.yaml'
      defaultContainer 'simple-agent'
    }
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
        withCredentials([VaultSSHUserPrivateKey(credentialsId: 'ID', usernameVariable: 'USERNAME', privateKeyVariable: 'KEY', passphraseVariable: 'PASSPHRASE')]) {
          echo '[Deploy] Realizando o deploy (simulado)...'
          sh 'echo "Usuário: $USERNAME"'
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
