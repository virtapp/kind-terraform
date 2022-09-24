resource "kubernetes_ingress" "ingress-route-argo" {
  metadata {
    name = "ingress-route-argo"
    namespace = "argocd"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"

      "nginx.ingress.kubernetes.io/backend-protocol" =  "HTTPS"

      "nginx.ingress.kubernetes.io/affinity" = "cookie"

      "nginx.ingress.kubernetes.io/session-cookie-expires" = "172800"

      "nginx.ingress.kubernetes.io/session-cookie-max-age" = "172800"

      "nginx.ingress.kubernetes.io/session-cookie-name" = "route"
    }
  }

  spec {
    rule {
      host = "argo.centerity.com"

      http {
        path {
          path = "/"

          backend {
            service_name = "argocd-server"
            service_port = "80"
          }
        }
      }
     }
      tls {
      secret_name = "centerity"
    }
  }
  # depends_on = [helm_release.argocd]
}


# Display load balancer hostname (typically present in local cluster)
output "load_balancer_hostname" {
  value = kubernetes_ingress.ingress-route-argo.status.0.load_balancer.0.ingress.0.hostname
}
