
# Provider block
provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "group3-eks"
}

# VPC 
module "vpc" { 
  source  = "terraform-aws-modules/vpc/aws" # This module creates VPC, subnets, RT, IGW, NAT gw, Elastic IP for NAT, RT associations

  name                 = "group3-eks-vpc"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true

  # Tags are used to determine which subnets to use for Load Balancers && What type of Load Balancer to associate with those subnets (public vs private)
  
  tags = { 
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"   
  }


  # Without these tags:
    # Kubernetes won’t know which subnet to use when it provisions an ELB.
    # ServiceType: LoadBalancer might fail to create the right resources in the right place.
    # Load balancers may end up misconfigured or in the wrong subnet tier.

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared" # Marks the subnet as associated with EKS cluster && 'shared' means it can be used by multiple resources
    "kubernetes.io/role/elb"                      = "1"  # Tells AWS that this subnet is suitable for public LoadBalancers && these are used for services of type LoadBalancer that are internet-facing
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1" # Marks the subnet for internal LB used for internal service communication
  }
}