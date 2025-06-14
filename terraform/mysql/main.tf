resource "helm_release" "mysql" {
  name       = "mysql"
  chart      = "${path.module}/../../helm-charts/mysql"
  namespace  = "default"
  values =    [file("${path.module}/../../helm-charts/mysql/values.yaml")]  

  set {
    name  = "mysqlRootPassword"
    value = "supersecret"
  }

  set {
    name  = "mysqlUser"
    value = "user"
  }

  set {
    name  = "mysqlPassword"
    value = "supersecret"
  }

  set {
    name  = "mysqlDatabase"
    value = "mydb"
  }
}
