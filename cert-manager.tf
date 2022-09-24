#deploy cert manager
resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.7.1"
  namespace        = "cert-manager"
  create_namespace = true
  #values = [file("cert-manager-values.yaml")]
  depends_on = [helm_release.argocd,kind_cluster.default]
  set {
    name  = "installCRDs"
    value = "true"
  }

}
