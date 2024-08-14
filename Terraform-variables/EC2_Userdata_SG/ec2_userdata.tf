resource "aws_instance" "webserver" {
	ami = lookup (var.ami, var.AWS_REGION)
	instance_type = "t2.micro"
	security_group = [aws_security_group.ec2_sg.id]
	subnet_id = [data.aws_subnet.GetSubnet]
	key_name = aws_key_pair.key_pair.key_name
	  user_data = <<EOF
	#! /bin/bash
	sudo su
	sudo yum update
	sudo yum install -y httpd
	sudo chkconfig httpd on
	sudo service httpd start
	echo "<h1> Deployed EC2 instance </h1>" | sudo tee /var/www/html/index.html

	EOF
	tags = {
	  Name = Linux
	  Environment = Dev
	}
}