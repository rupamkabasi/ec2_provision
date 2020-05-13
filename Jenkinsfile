pipeline {
    agent { label 'rhel_build'}

    stages {
        stage('scp checkout') {
            steps {
                echo 'cloning repo'
                git 'https://github.com/rupamkabasi/ec2_provision.git'
                sh 'chmod -R 777 *'
            }
        }
        stage('Build') {
            steps {
                echo 'provisioning EC2'
                sh 'cd terraform-aws-instance && ./ec2_provision.sh'
            }
        }
        stage('teardown') {
            input {
                message "Want to teardown"
            }
            steps {
                echo 'Tearing down EC2'
                sh 'cd terraform-aws-instance && ./ec2_teardown.sh'
            }
        }
    }
}