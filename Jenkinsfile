pipeline {
    agent any 
    stages {
        stage ('Clean Workspace') {
            steps {
                script{
                    remote = [:]
                    remote.name = "root"
                    remote.host = params.IP_ADDRESS
                    remote.allowAnyHosts = true
                    remote.failOnError = true
                    withCredentials([usernamePassword(credentialsId: 'adi-cerd', passwordVariable: 'password', usernameVariable: 'username')]) {
                        remote.user = params.LINUX_USER
                        remote.password = params.LINUX_PASS
                        sshCommand remote: remote, command: "rm -rf /tmp/global-deployment"
                    }
                }
           }
        }
        stage ('Clone Repository') {
            steps {
                script{
                    remote = [:]
                    remote.name = "root"
                    remote.host = params.IP_ADDRESS
                    remote.allowAnyHosts = true
                    remote.failOnError = true
                    withCredentials([usernamePassword(credentialsId: 'adi-cerd', passwordVariable: 'password', usernameVariable: 'username')]) {
                        remote.user = params.LINUX_USER
                        remote.password = params.LINUX_PASS
                        sshCommand remote: remote, command: "yum install git -y && cd /tmp && git clone -b centos https://DEVOPS-TOKEN-global:5wqbyxU8YMfK7VNosPkt@gitlab.com/centerity/global-deployment.git"
                    }
                }
           }
        }
        stage ('Install App') {
            steps {
                script{
                    remote = [:]
                    remote.name = "root"
                    remote.host = params.IP_ADDRESS
                    remote.allowAnyHosts = true
                    remote.failOnError = true
                    withCredentials([usernamePassword(credentialsId: 'adi-cerd', passwordVariable: 'password', usernameVariable: 'username')]) {
                        remote.user = params.LINUX_USER
                        remote.password = params.LINUX_PASS
                        sshCommand remote: remote, command: "cd /tmp/global-deployment && bash install.sh"
                    }
                }
           }
        }
    }
}
