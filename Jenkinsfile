pipeline { 
    environment { 
        repository = "beanbeeean/onboarding"  
	registry = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
  }
  agent any
  
  stages { 
      stage('Building our image') { 
          steps { 
              script {
		sh "docker build -t $repository:$BUILD_NUMBER ." 
              }
          } 
      }
      stage('Push Image') {
            steps {
                script{
			sh "docker tag $repository:$BUILD_NUMBER $registry"
			sh "docker push public.ecr.aws/k3f1h3u2/btc3-ecr"
		  }
                }
            }
      stage('Cleaning up') { 
		  steps { 
              sh "docker rmi $repository:$BUILD_NUMBER" 
          }
      } 
  }
    }
