# Creating namespace with the Kubernetes provider is better than auto-creation in the helm_release.
# You can reuse the namespace and customize it with quotas and labels.
resource "kubernetes_namespace" "centerity" {
  metadata {
    name = var.namespace
  }
    depends_on = [kind_cluster.default]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace
  }
    depends_on = [kind_cluster.default]
}
