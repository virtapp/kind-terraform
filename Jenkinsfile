pipeline {
    agent any 
    stages {
        stage ('Clean Workspace') {
            steps {
                script{
                    remote = [:]
                    remote.name = "ubuntu"
                    remote.host = params.IP_ADDRESS
                    remote.allowAnyHosts = true
                    remote.failOnError = true
                    withCredentials([usernamePassword(credentialsId: 'user-cred', passwordVariable: 'password', usernameVariable: 'username')]) {
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
                    remote.name = "ubuntu"
                    remote.host = params.IP_ADDRESS
                    remote.allowAnyHosts = true
                    remote.failOnError = true
                    withCredentials([usernamePassword(credentialsId: 'user-cred', passwordVariable: 'password', usernameVariable: 'username')]) {
                        remote.user = params.LINUX_USER
                        remote.password = params.LINUX_PASS
                        sshCommand remote: remote, command: "apt-get install git -y && cd /tmp && git clone -b main https://github.com/virtapp/kind-terraform.git"
                    }
                }
           }
        }
        stage ('Install App') {
            steps {
                script{
                    remote = [:]
                    remote.name = "ubuntu"
                    remote.host = params.IP_ADDRESS
                    remote.allowAnyHosts = true
                    remote.failOnError = true
                    withCredentials([usernamePassword(credentialsId: 'user-cred', passwordVariable: 'password', usernameVariable: 'username')]) {
                        remote.user = params.LINUX_USER
                        remote.password = params.LINUX_PASS
                        sshCommand remote: remote, command: "cd /tmp/kind-terraform && bash install.sh"
                    }
                }
           }
        }
    }
}
