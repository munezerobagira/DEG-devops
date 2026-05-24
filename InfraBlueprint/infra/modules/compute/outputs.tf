output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "web_sg_id" {
  description = "Security group ID for the web tier."
  value       = aws_security_group.web_sg.id
}