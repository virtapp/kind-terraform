#!/bin/bash

apt-get update -y && apt-get install docker.io -y
   echo    "----- ..................................................... -----"
   echo      "----- ...............   TERRAFORM .................... -----"
   echo    "----- ..................................................... -----"
wget https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip
sudo apt install zip -y
sudo unzip terraform_0.14.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/
sleep 5
   echo    "----- ..................................................... -----"
   echo        "----- ...............   HELM .................... -----"
   echo    "----- ..................................................... -----"
curl -# -LO https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz
tar -xzvf helm-v3.5.3-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm-v3.5.3-linux-amd64.tar.gz && rm -rf linux-amd64
sleep 5
   echo    "----- ..................................................... -----"
   echo       "----- ...............   KUBECTL .................... -----"
   echo    "----- ..................................................... -----"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
