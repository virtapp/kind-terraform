###---infra

resource "helm_release" "influxdb" {
  namespace        = "infra"
  create_namespace = true
  depends_on = [kind_cluster.default]

  name       = "influxdb"
  chart = "${var.charts_path}/influxdb/"


  set {
    name  = "adminUser.pwd"
    value = "gdgfdgdgdgd"
  }

  set {
    name  = "writeUser.pwd"
    value = "ttnnnnnnnnhn"
  }

  set {
    name  = "readUser.pwd"
    value = "dffddgdhhghf"
  }
}
