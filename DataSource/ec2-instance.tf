resource "aws_instance" "ec2-vm" {
  ami   = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  key_name = "terraform-key"
        user_data = file ("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.web.id]
  tags = {
    "Name" = "amz-linux-vm"
  }
 
}
