#!/usr/bin/env sh

set -e
cat <<EOF

Typical installation of the Local Environment , the time of installation between 5-7 minutes
    1. ### Install Packages
    2. ### Create Kubernetes Cluster
    3. ### Deploy Charts of Application  
EOF
sleep 5
export path_charts="charts"
export path_folder="argocd"
             echo      "----- ............................. -----"
             echo         "---  Install Dependencies ---"
             echo      "----- ............................. -----"
source dependency.sh
sleep 5 && docker ps -a || true

             echo      "----- ............................. -----"
             echo         "---  LOAD-TERRAFORM-FILES  ---"
             echo      "----- ............................. -----"
sleep 5         
terraform init && terraform plan
terraform apply -auto-approve
sleep 10 && kubectl get pods -A && sleep 5

             echo      "----- ............................. -----"
             echo          "---  HELM UPDATE REPO  ---"
             echo      "----- ............................. -----"
             
helm repo add bitnami https://charts.bitnami.com/bitnami || true
helm repo add hashicorp https://helm.releases.hashicorp.com|| true
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest || true
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts || true
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts || true
helm repo add kedacore https://kedacore.github.io/charts || true
helm repo update && sleep 5
helm fetch rancher-latest/rancher --version=v2.6.2 || true
kubectl create namespace cattle-system || true
kubectl create namespace keda || true
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver || true
helm install keda kedacore/keda --namespace keda && sleep 5
echo    Waiting for all pods in running mode:
until kubectl wait --for=condition=Ready pods --all -n keda; do
sleep 2
done  2>/dev/null

             echo      "----- ............................. -----"
             echo         "---  LOAD-ARGO-APPLICATIONS  ---"
             echo      "----- ............................. -----"           
sleep 5 &&           
kubectl apply -f ./${path_folder}/app-apache.yaml
kubectl apply -f ./${path_folder}/app-httpd.yaml
sleep 5 && 
kubectl create namespace centerity || true
kubectl apply -f ./${path_folder}/secret.yaml || true
kubectl apply -f ./${path_folder}/infra.yaml || true
               printf "\nWaiting for application will be ready... \n"
printf "\nYou should see 'dashboard' as a reponse below (if you do the ingress is working):\n"

             echo      "----- ............................. -----"
             echo         "---  CREATE INGRESS RULES  ---"
             echo      "----- ............................. -----"
             
kubectl apply -f ./${path_folder}/ingress-keyclock.yaml
kubectl apply -f ./${path_folder}/ingress-argocd.yaml
sleep 5 && 
kubectl get nodes -o wide && sleep 5
terraform providers

             echo      "----- ............................. -----"
             echo           "---  CLUSTER IS READY  ---"
             echo      "----- ............................. -----"
