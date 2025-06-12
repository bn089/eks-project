provider "helm" { # Telling terraform that we are going to use Helm inside K8s
  kubernetes {
    config_path = "/home/ubuntu/.kube/config" # Use the kubeconfig file at config_path to connect to my EKS cluster
  }
}

resource "helm_release" "kubernetes_dashboard" { # Comes from Terraform registry helm provider resource 
  name       = "kubernetes-dashboard" 
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  namespace  = "kubernetes-dashboard"
  create_namespace = true

  values = [file("dashboard-values.yaml")] # Read additional configuration from this file && Helm uses these values to customize the default chart behavior. 
}