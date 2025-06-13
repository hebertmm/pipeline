pipeline {
  agent {
    kubernetes {
      yamlFile 'pod-template.yaml'
      defaultContainer 'simple-agent'
    }
  }

  stages {
    stage('Print') {
      steps {
        sh 'echo "Olá! Pipeline executando no pod Kubernetes com sucesso!"'
      }
    }
  }
}
