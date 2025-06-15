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
        echo '[Deploy] Enviando para ambiente de homologação (simulado)...'
        sh 'sleep 1'
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
