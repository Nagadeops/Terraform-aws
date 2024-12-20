# Input Variables

# AWS Region
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable"
  type        = string
  default     = "development"
}

# Project
variable "project" {
  description = "project"
  type        = string
  default     = "demo"
}