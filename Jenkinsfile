pipeline {
    agent any
    stages {
        stage('Test Azure Login') {
            steps {
                withCredentials([azureServicePrincipal(
                    credentialsId: 'azure-sp-credentials',
                    subscriptionIdVariable: 'SUBSCRIPTION_ID',
                    clientIdVariable: 'CLIENT_ID',
                    clientSecretVariable: 'CLIENT_SECRET',
                    tenantIdVariable: 'TENANT_ID'
                )]) {
                    sh '''
                    echo "Client ID: $CLIENT_ID"
                    echo "Tenant ID: $TENANT_ID"
                    echo "Subscription ID: $SUBSCRIPTION_ID"
                    az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID
                    az account set --subscription $SUBSCRIPTION_ID
                    '''
                }
            }
        }
        stage('Clone Repository') {
            steps {
                git 'https://github.com/dhinasurya/terraform-jenkins.git'
            }
        }
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -var-file="rare.tfvars" -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    input message: 'Apply the Terraform plan?', ok: 'Apply'
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
    post {
        success {
            echo 'Terraform applied successfully!'
        }
        failure {
            echo 'Failed to apply Terraform configuration.'
        }
    }
}
