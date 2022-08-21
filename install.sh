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
helm install keda kedacore/keda --namespace keda && sleep 5
helm install rancher rancher-latest/rancher --version=v2.6.2 \
  --namespace cattle-system \
  --set hostname=console.centerity.com \
  --set ingress.tls.source=centerity
echo    Waiting for all pods in running mode:
until kubectl wait --for=condition=Ready pods --all -n cattle-system; do
sleep 2
done  2>/dev/null

             echo      "----- ............................. -----"
             echo         "---  LOAD-ARGO-APPLICATIONS  ---"
             echo      "----- ............................. -----"
             
sleep 5             
kubectl apply -f ./${path_folder}/app-apache.yaml
kubectl apply -f ./${path_folder}/app-httpd.yaml
kubectl apply -f ./${path_folder}/app-prometheus.yaml
sleep 5
             printf "\nWaiting for application will be ready... \n"
printf "\nYou should see 'foo' as a reponse below (if you do the ingress is working):\n"
kubectl apply -f ./${path_folder}/ingress-keyclock.yaml
kubectl apply -f ./${path_folder}/ingress-argocd.yaml
sleep 5
kubectl get nodes -o wide && sleep 5
terraform providers
             echo      "----- ............................. -----"
             echo           "---  CLUSTER IS READY  ---"
             echo      "----- ............................. -----"
