# Define Local Values in Terraform
locals {
  owners      = var.project
  environment = var.environment
  name        = "${var.project}-${var.environment}"

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}