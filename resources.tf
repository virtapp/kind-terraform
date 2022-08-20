###-keycloak
resource "helm_release" "keycloak" {
  name       = "keycloak"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  create_namespace = true
  depends_on = [kind_cluster.default]

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
  depends_on = [kind_cluster.default]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
