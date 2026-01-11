pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/<your-repo>/eks-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'cd eks && terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'cd eks && terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'cd eks && terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Configure Kubeconfig') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                    aws eks update-kubeconfig --region ${AWS_REGION} --name demo-cluster
                    kubectl get nodes
                    '''
                }
            }
        }

        stage('Deploy Nginx') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh '''
                    kubectl create deployment nginx-app --image=nginx || true
                    kubectl expose deployment nginx-app --type=LoadBalancer --port=80 || true
                    kubectl get svc nginx-app
                    '''
                }
            }
        }
    }
}
