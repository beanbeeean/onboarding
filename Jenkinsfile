pipeline {
    environment {
        repository = "beanbeeean/onboarding"  
        registry = 'public.ecr.aws/k3f1h3u2/btc3-ecr'
	IMAGES_TO_KEEP=3
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
                script {
                    sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin $registry"
                    sh "docker tag $repository:$BUILD_NUMBER $registry:$BUILD_NUMBER"
                    sh "docker push $registry:$BUILD_NUMBER"
	            sh "aws ecr-public describe-images --repository-name $registry --query 'sort_by(imageDetails,& imagePushedAt)[*].imageDigest' --output text | head -n -$IMAGES_TO_KEEP | xargs -I {} aws ecr-public batch-delete-image --repository-name $registry --image-ids imageDigest={}"
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $repository:$BUILD_NUMBER"
		sh "ls -a"
            }
        }
        stage('Deploy') {
            steps {
		     withCredentials([usernamePassword(credentialsId: 'hjh-github', usernameVariable: 'username', passwordVariable: 'password')]) {
			sh """
   				rm -rf ./onboarding-argo
       				git clone git@github.com:beanbeeean/onboarding-argo.git
	   			cd ./onboarding-argo
				ls -a
	                        git config --global user.email 'beanbeeean@naver.com'
	                        git config --global user.name 'beanbeeean'
				git config --global credential.helper store
				git remote set-url origin git@github.com:beanbeeean/onboarding-argo.git
				sed -i 's/tag:.*/tag: $BUILD_NUMBER/g' ./charts/prod/values.yaml
				git add .
	                        git commit -m 'update deployment'
	                        git push -u origin main
   			   """
                    }
            }
        }
    }
    post {
        success {
            slackSend (channel: '#jenkins-alarm', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure {
            slackSend (channel: '#jenkins-alarm', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}

