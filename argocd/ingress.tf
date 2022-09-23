###-ingress-argocd
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
      host = "argo.appflex.io"

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
      secret_name = "appflex"
    }
  }
   depends_on = [helm_release.argocd,helm_release.ingress_nginx]
}
