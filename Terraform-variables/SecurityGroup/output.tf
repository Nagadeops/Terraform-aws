output "SID" {
  value       = aws_security_group.ec2_sg.id
  description = "A reference to the created NACL Inbound Rule"
}