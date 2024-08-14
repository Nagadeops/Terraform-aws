terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
# Configure VPC

resource "aws_vpc" "prodvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Prodvpc"
  }
}
# Configure public subnet
resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.prodvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Pubsub"
  }
}
# Configure private subnet
resource "aws_subnet" "privsub" {
  vpc_id     = aws_vpc.prodvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Privsub"
  }
}
# Create internet gateway
resource "aws_internet_gateway" "tigw" {
  vpc_id = aws_vpc.prodvpc.id

  tags = {
    Name = "ProdIGW"
  }
}
# Create Public Route table
resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.prodvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }

  tags = {
    Name = "PubRT"
  }
}
# Public Route table association
resource "aws_route_table_association" "pubrtasso" {
  subnet_id      = aws_subnet.pubsub.id
  route_table_id = aws_route_table.pubrt.id
}
# Create EIP
resource "aws_eip" "prodeip" {
  vpc = true
}
# Create Nat Gateway
resource "aws_nat_gateway" "tnat" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.pubsub.id

  tags = {
    Name = "NAT GW"
  }

# Create Private Route table
resource "aws_route_table" "privrt" {
  vpc_id = aws_vpc.prodvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tnat.id
  }

  tags = {
    Name = "PrivRT"
  }
}
# Private Route table association
resource "aws_route_table_association" "privrtasso" {
  subnet_id      = aws_subnet.privsub.id
  route_table_id = aws_route_table.privrt.id
}

# Security group

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow RDP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prodvpc.id

  tags = {
    Name = "allow_RDP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_rdp_ipv4" {
  security_group_id = aws_security_group.allow_rdp.id
  cidr_ipv4         = ["0.0.0.0/0"]
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_rdp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "jumpbox" {
ami	= ""
instance_type = "t2.micro"
subnet_id	= aws_subnet.pubsub.id
vpc_security_group_ids	=	["${aws_security_group_allow_rdp.id}"]
key_name	=	LaptopKey
associate_public_ip_address	=	true
}

resource "aws_instance" "memberserver" {
ami	= ""
instance_type = "t2.micro"
subnet_id	= aws_subnet.privsub.id
vpc_security_group_ids	=	["${aws_security_group_allow_rdp.id}"]
key_name	=	LaptopKey
}
