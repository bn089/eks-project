
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
    aws = {
      source  = "hashicorp/aws"
    }
    local = {
      source  = "hashicorp/local"
    }
    null = {   # is needed to trigger scripts without creating infrastructure
      source  = "hashicorp/null"
    }
    cloudinit = { # used for installing packages or setting up the environment at launch time
      source  = "hashicorp/cloudinit"
    }
  }
}