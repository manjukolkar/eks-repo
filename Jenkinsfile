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
                sh '''
                cd eks
                terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                cd eks
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                cd eks
                terraform apply -auto-approve tfplan
                '''
            }
        }

        stage('Kubeconfig Update') {
            steps {
                sh '''
                aws eks update-kubeconfig --region ${AWS_REGION} --name demo-cluster
                kubectl get nodes
                '''
            }
        }

        stage('Deploy Nginx App') {
            steps {
                sh '''
                kubectl create deployment nginx-app --image=nginx
                kubectl expose deployment nginx-app --port=80 --type=LoadBalancer
                kubectl get svc nginx-app
                '''
            }
        }
    }
}
