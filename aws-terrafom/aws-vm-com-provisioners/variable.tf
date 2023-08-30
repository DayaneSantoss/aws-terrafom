variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3 que armazena o estado do Terraform."
  type        = string
  default = "remote-state-terraform-equipe-2"
}

variable "tags" {
  type = map(any)
  default = {
    owner      = "equipe-2"
    managed-by = "terraform"
  }
}
