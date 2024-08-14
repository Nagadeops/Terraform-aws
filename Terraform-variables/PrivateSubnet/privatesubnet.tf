resource "aws_subnet" "PrivateSubnet1" {
	vpc_id = data.aws_vpc.GetVPC.id
	cidr_block = "10.0.3.0/24"
	availability_zone = "us-east-1a"
	
	tags = {
	  Name = "PrivateSubnet1"
	}
}