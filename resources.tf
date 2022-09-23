###-keycloak
resource "helm_release" "keycloak" {
  name       = "keycloak"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  create_namespace = true
  depends_on = [helm_release.argocd,kind_cluster.default]]

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
  depends_on = [helm_release.argocd,kind_cluster.default]

  set {
    name  = "service.type"
    value = "ClusterIP"
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

  depends_on = [helm_release.argocd,kind_cluster.default]
}


###-vault
resource "helm_release" "vault" {
  chart            = "vault"
  name             = "vault"
  namespace        = "vault"
  create_namespace = true
  repository       = "https://helm.releases.hashicorp.com"
  depends_on = [helm_release.argocd,kind_cluster.default]
  values = [
    file("argocd/vault-values.yaml")
  ]
}
