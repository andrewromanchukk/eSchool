pipeline {

  agent any
  environment 
      {
        DATASOURCE_URL = "104.198.247.139"
        DATASOURCE_USERNAME = 'eschool'
        DATASOURCE_PASSWORD = '1234'
      }
  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/andrewromanchukk/backend-eschool-k8s.git', branch:'master'
      }
    }
    
      stage("Build image") {
            // environment {
            //     DB_HOST = credentials('DB_HOST')
            //     DB_USER = credentials('DB_USER')
            //     DB_PASSWORD = credentials('DB_PASSWORD')
            //   }
            steps {
                script {
                    myapp = docker.build("igneous-sum-312016/hellowhale:${BUILD_ID}", "--build-arg DATASOURCE_URL=$DATASOURCE_URL --build-arg DATASOURCE_USERNAME=$DATASOURCE_USERNAME --build-arg DATASOURCE_PASSWORD=$DATASOURCE_PASSWORD --no-cache .")
                }
            }
        }
    
      stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://eu.gcr.io/igneous-sum-312016/hellowhale', 'gcr:gcr_eschool') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }

    
  //   stage('Deploy App') {
  //     steps {
  //       script {
  //         kubernetesDeploy(configs: "hellowhale.yml", kubeconfigId: "mykubeconfig")
  //       }
  //     }
  //   }

  // }
  }
}