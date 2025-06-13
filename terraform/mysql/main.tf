resource "helm_release" "mysql" {
  name       = "mysql"
  chart      = "${path.module}/../../helm-charts/mysql"
  namespace  = "default"

  set {
    name  = "mysqlRootPassword"
    value = "supersecret"
  }

  set {
    name  = "mysqlUser"
    value = "hello"
  }

  set {
    name  = "mysqlPassword"
    value = "kaizen123"
  }

  set {
    name  = "mysqlDatabase"
    value = "testdb"
  }
}
