###-keycloak
resource "helm_release" "keycloak" {
  name       = "keycloak"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  create_namespace = true
  depends_on = [helm_release.argocd,kind_cluster.default]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}


