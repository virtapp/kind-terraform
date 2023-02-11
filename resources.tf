###-argocd
resource "helm_release" "argocd" {
  name  = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "4.9.7"
  create_namespace = true
  timeout = 300

  values = [
    file("argocd/argo-values.yaml")
  ]
  depends_on = [kind_cluster.default]
}

resource "null_resource" "wait_for_argocd" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      printf "\nWaiting for the argocd controller will be installed...\n"
      kubectl wait --namespace ${helm_release.argocd.namespace} \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=server \
        --timeout=60s
    EOF
  }

  depends_on = [helm_release.argocd]
}


###-keycloak
resource "helm_release" "keycloak" {
  name       = "keycloak"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  create_namespace = true
  timeout = 300
  values = [
    file("config/keycloak-value.yaml")
  ]
  depends_on = [helm_release.argocd]
}


#deploy cert manager
resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.7.1"
  namespace        = "cert-manager"
  create_namespace = true
  timeout = 300
  #values = [file("cert-manager-values.yaml")]
  depends_on = [helm_release.argocd]
  set {
    name  = "installCRDs"
    value = "true"
  }

}
