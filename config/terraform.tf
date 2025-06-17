terraform {
  required_version = "1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.0"
    }
  }
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN
