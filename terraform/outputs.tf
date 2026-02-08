output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.app_ec2instance.public_ip
}