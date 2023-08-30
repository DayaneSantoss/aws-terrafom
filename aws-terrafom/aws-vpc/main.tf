terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }
  backend "s3" {
    bucket = "remote-state-terraform-equipe-2"
    key    = "aws-vpc/terraform.tfstate"
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
data "terraform_remote_state" "bucket" {
  backend = "s3"
  config = {
    bucket = var.bucket_name
    key    = "aws-remote-state/terraform.tfstate"
    region = var.aws_region
  }
}
