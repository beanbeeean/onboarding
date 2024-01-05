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
                script {
                    sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin $registry"
                    sh "docker tag $repository:$BUILD_NUMBER $registry:$BUILD_NUMBER"
                    sh "docker push $registry:$BUILD_NUMBER"
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
			sh "rm -rf ./onboarding-argo"
			sh "git clone git@github.com:beanbeeean/onboarding-argo.git"
			sh "cd ./onboarding-argo"
			sh "ls -a"
                        sh "git config --global user.email 'beanbeeean@naver.com'"
                        sh "git config --global user.name 'beanbeeean'"
			sh "git config --global credential.helper store"
			sh "git remote set-url origin git@github.com:beanbeeean/onboarding-argo.git"
			sh "git pull origin main"
			sh "sed -i 's/tag:.*/tag: $BUILD_NUMBER/g' onboarding-argo/charts/prod/values.yaml"
			sh "git add ."
                        sh "git commit -m 'update deployment'"
                        sh "git push -u origin main"
                    }
            }
        }
    }
}

