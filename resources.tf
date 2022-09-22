###-keycloak
resource "helm_release" "keycloak" {
  name       = "keycloak"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  create_namespace = true
  depends_on = [helm_release.rancher_server]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}


###-grafana
resource "helm_release" "grafana" {
  name       = "grafana"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"
  create_namespace = true
  depends_on = [helm_release.rancher_server]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}


###-rancher
resource "helm_release" "rancher_server" {

  name             = "rancher"
  chart            = "https://releases.rancher.com/server-charts/latest/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true
  depends_on = [helm_release.ingress_nginx]

  set {
    name  = "hostname"
    value = var.rancher_server_dns
  }

  set {
    name  = "ingress.tls.source"
    value = "centerity"
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin" # TODO: change this once the terraform provider has been updated with the new pw bootstrap logic
  }
}


###-keda
resource "helm_release" "keda" {
  name = "keda"

  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  namespace  = "keda"
  atomic     = true
  create_namespace = true

  depends_on = [helm_release.rancher_server]
}


###-vault
resource "helm_release" "vault" {
  chart            = "vault"
  name             = "vault"
  namespace        = "vault"
  create_namespace = true
  repository       = "https://helm.releases.hashicorp.com"
  depends_on = [helm_release.rancher_server]
  values = [
    file("argocd/vault-values.yaml")
  ]
}
