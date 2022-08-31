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

###-devtron
resource "helm_release" "devtron" {
  name       = "devtron"
  repository = "https://helm.devtron.ai"
  chart      = "devtron-operator"
  version    = var.devtron_helm_version

  namespace        = var.devtron_namespace
  create_namespace = true

  values = [file("devtron.yaml")]

  timeout = 600000

  depends_on = [kind_cluster.default]
}
