
###-rancher
resource "helm_release" "rancher_server" {

  name             = "rancher"
  chart            = "https://releases.rancher.com/server-charts/latest/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true
  depends_on = [kind_cluster.default]

  set {
    name  = "hostname"
    value = var.rancher_server_dns
  }

  set {
    name  = "ingress.tls.source"
    value = "appflex"
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

