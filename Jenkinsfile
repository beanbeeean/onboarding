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
			sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin $registry"
			sh "docker tag $repository:$BUILD_NUMBER $registry:$BUILD_NUMBER"
			sh "docker push $registry:$BUILD_NUMBER"
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
