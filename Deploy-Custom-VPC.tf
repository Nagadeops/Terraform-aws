terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.66.1"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_vpc" "lab_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lab_vpc"
  }
}

resource "aws_subnet" "lab_public_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "lab_public_subnet"
  }
}

resource "aws_subnet" "lab_private_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "lab_private_subnet"
  }
}

resource "aws_security_group" "lab_sg" {
   name        = "lab_sg"
   description = "Allow SSH traffic"
   vpc_id      = aws_vpc.lab_vpc.id

  ingress {
     description      = "Allow SSH"
     from_port        = 22
     to_port          = 22
     protocol         = "tcp"
     cidr_blocks      = [aws_vpc.lab_vpc.cidr_block, "0.0.0.0/0"]
   }

   egress {
     from_port        = 0
     to_port          = 0
     protocol         = "-1"
     cidr_blocks      = ["0.0.0.0/0"]
   }

   tags = {
     Name = "allow_ssh"
   }
 }

 resource "aws_internet_gateway" "lab_igw" {
   vpc_id = aws_vpc.lab_vpc.id

   tags = {
     Name = "lab_igw"
   }
 }

  resource "aws_eip" "lab_elastic_ip" {
   vpc = true
 }

 resource "aws_nat_gateway" "lab_nat_gateway" {
   allocation_id = aws_eip.lab_elastic_ip.id
   subnet_id     = aws_subnet.lab_public_subnet.id 

   tags = {
     Name = "Lab NAT Gateway"
   }
   depends_on = [aws_internet_gateway.lab_igw]
 }

resource "aws_route_table" "lab_vpc_public_RouteTable" {
   vpc_id = aws_vpc.lab_vpc.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.lab_igw.id
   }

   tags = {
     Name = "VPC_Public_RouteTable"
   }
 }

 resource "aws_route_table" "lab_vpc_private_RouteTable" {
   vpc_id = aws_vpc.lab_vpc.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_nat_gateway.lab_nat_gateway.id
   }

   tags = {
     Name = "VPC_Private_RouteTable"
   }
 }

 resource "aws_route_table_association" "lab_public_RouteTable_Assoc" {
   subnet_id      = aws_subnet.lab_public_subnet.id
   route_table_id = aws_route_table.lab_vpc_public_RouteTable.id
 }

 resource "aws_route_table_association" "lab_private_RouteTable_Assoc" {
   subnet_id      = aws_subnet.lab_private_subnet.id
   route_table_id = aws_route_table.lab_vpc_private_RouteTable.id
 }

resource "aws_instance" "Web_Server" {
   ami = ""
   instance_type = "t3.micro"
   key_name = "Linux-VM-3"
   subnet_id = aws_subnet.lab_public_subnet.id
   vpc_security_group_ids = [aws_security_group.lab_sg.id]
   associate_public_ip_address = true
   root_block_device {
     volume_type = "gp3"
     volume_size = "20"
     delete_on_termination = true
   }
   ebs_block_device {
   device_name = "/dev/xvdb"
   delete_on_termination = true
   volume_size = 32
   volume_type = "gp3"
   }
   tags = {
     Name = "Web_Server"
   }
 }
