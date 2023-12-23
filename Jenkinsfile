pipeline { 
    environment { 
        repository = "beanbeeean/onboarding"  
        dockerImage = ''
	registry = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
	registryCredential = 'hjh-ecr'
	app = '' 
  }
  agent any
  
  stages { 
      stage('Building our image') { 
          steps { 
              script { 
                  app = docker.build("$repository:$BUILD_NUMBER .") 
              }
          } 
      }
      stage('Push Image') {
            steps {
                script{
                    docker.withRegistry("https://" + $registry, "ecr:ap-northeast-2:" + $registryCredential){
                      app.push("${version}")
                      app.push("latest")
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
