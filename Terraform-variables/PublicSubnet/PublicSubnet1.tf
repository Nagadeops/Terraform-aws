resource "aws_subnet" "PublicSubnet1" {
	vpc_id = data.aws_vpc.GetVPC.id
	cidr_block = "10.0.1.0/24"
	availability_zone = "us-east-1a"
	
	tags = {
	  Name = "PublicSubnet1"
	}
}

resource "aws_subnet" "PublicSubnet2" {
	vpc_id = data.aws_vpc.GetVPC.id
	cidr_block = "10.0.2.0/24"
	availability_zone = "us-east-1b"
	map_public_ip_on_launch = true

	tags = {
	  Name = "PublicSubnet2"
	}
}