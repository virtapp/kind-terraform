resource "kubernetes_ingress" "rudeckpro_nginx" {
  metadata {
    name = "rudeckpro-nginx"

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"

      "nginx.ingress.kubernetes.io/affinity" = "cookie"

      "nginx.ingress.kubernetes.io/session-cookie-expires" = "172800"

      "nginx.ingress.kubernetes.io/session-cookie-max-age" = "172800"

      "nginx.ingress.kubernetes.io/session-cookie-name" = "route"
    }
  }

  spec {
    rule {
      host = "localhost"

      http {
        path {
          path = "/"

          backend {
            service_name = "rundeckpro"
            service_port = "8080"
          }
        }
      }
    }
  }
}
