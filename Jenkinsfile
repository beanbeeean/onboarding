pipeline { 
    environment { 
        repository = "beanbeeean/onboarding"  
        dockerImage = '' 
  }
  agent any

  tools {
	dockerTool 'dockerTool'
  }
  
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
                    docker.withRegistry("https://" + registry, "ecr:ap-northeast-2:" + registryCredential){
                      docker.image("$repository:$BUILD_NUMBER").push()
                      docker.image("$BUILD_NUMBER:latest").push()
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
