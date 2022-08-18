#!/usr/bin/env sh

set -e
export path_folder="argocd"
source dependency.sh
sleep 5 && docker ps -a || true

             echo      "----- ............................. -----"
             echo         "---  LOAD-CONFIG-TERRAFORM  ---"
             echo      "----- ............................. -----"
sleep 5         
terraform init && terraform plan
terraform apply -auto-approve
sleep 10 && kubectl get pods -A && sleep 5

             echo      "----- ............................. -----"
             echo         "---  LOAD-ARGO-APPLICATIONS  ---"
             echo      "----- ............................. -----"
             
sleep 5             
kubectl apply -f ./${path_folder}/app-apache.yaml
kubectl apply -f ./${path_folder}/app-httpd.yaml
kubectl apply -f ./${path_folder}/ingress-argocd.yaml
sleep 5
             printf "\nWaiting for application will be ready... \n"
printf "\nYou should see 'foo' as a reponse below (if you do the ingress is working):\n"
kubectl get nodes -o wide && sleep 5
terraform providers
             echo      "----- ............................. -----"
             echo           "---  CLUSTER IS READY  ---"
             echo      "----- ............................. -----"
