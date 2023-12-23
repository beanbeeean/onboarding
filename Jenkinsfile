pipeline { 
    environment { 
        repository = "beanbeeean/onboarding"  
        dockerImage = '' 
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
	            def docker = tool name: 'Docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
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
