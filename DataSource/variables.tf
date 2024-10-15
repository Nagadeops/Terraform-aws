variable "aws_region" {
  description = "In which region aws resources to be created"  
  type = string
  default = "us-east-1"
}


variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"
}
