pipeline { 
    environment { 
        repository = "beanbeeean/onboarding"  
        dockerImage = ''
	registry = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
	registryCredential = 'hjh-cicd'
	app = '' 
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
                    docker.withRegistry("https://public.ecr.aws/k3f1h3u2/btc3-ecr", "ecr:ap-northeast-2:" + registryCredential){
	            docker.image("repository:${env.BUILD_NUMBER}").push()
                    docker.image("${env.BUILD_NUMBER}:latest").push()
			}  
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
