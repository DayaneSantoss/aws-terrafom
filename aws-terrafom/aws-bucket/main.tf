terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"

    }
  }
  backend "s3" {
    bucket = "remote-state-terraform-equipe-2"
    key    = "aws-remote-state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner      = var.tags.owner
      managed-by = var.tags.managed-by
    }
  }
}
