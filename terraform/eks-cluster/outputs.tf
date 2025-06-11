output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id 
}

output "cluster_endpoint" { # Outputs the API server endpoint you can use to connect your kubectl client to the cluster
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" { # Returns the security group ID that protects the EKS control plane
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "oidc_provider_arn" {  # Outputs the ARN of your OIDC provider for EKS &&  often need this when you want to configure IAM Roles for Service Accounts (IRSA) in K8s
  value = module.eks.oidc_provider_arn
}

output "zz_update_kubeconfig_command" { # The zz_ prefix is often used informally to make this output appear last or near the bottom in the Terraform output list. Because Terraform outputs are sorted alphabetically, naming something with zz_ pushes it toward the end, so it’s easy to find.
#   value = "aws eks update-kubeconfig --name " + module.eks.cluster_id
  value = format("aws eks update-kubeconfig --name %s --region %s", module.eks.cluster_name, var.aws_region)
}

# The goal of this Terraform output is to generate the exact AWS CLI command you need to run on your local machine to configure your Kubernetes client (kubectl) so it can connect to your new EKS cluster.
# aws eks update-kubeconfig — This AWS CLI command updates your local kubeconfig file (usually ~/.kube/config).

# It adds the EKS cluster’s access details to your kubeconfig.
# This lets kubectl communicate securely with the EKS cluster you just created.
# --name specifies the name of your EKS cluster.
# --region tells AWS CLI which AWS region the cluster is in.