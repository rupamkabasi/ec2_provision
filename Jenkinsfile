pipeline {
    agent { label ''}

    stages {
        stage('scp checkout') {
            steps {
                echo 'cloning repo'
                git 'https://github.com/rupamkabasi/ec2_provision.git'
            }
        }
        stage('Build') {
            steps {
                echo 'provisioning EC2'
                cd terraform-aws-instance && sh ec2_provision.sh  
            }
        }
        stage('teardown') {
            input {
                message "Want to teardown"
            }
            steps {
                echo 'Tearing down EC2'
                cd terraform-aws-instance && sh ec2_teardown.sh
            }
        }
    }
}