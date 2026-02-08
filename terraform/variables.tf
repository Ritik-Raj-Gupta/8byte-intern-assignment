variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}
variable "subnet_cidr" {
  description = "CIDR block for public subnet of app"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "ec2_ssh_key_name" {
  description = "EC2 key pair name"
  type        = string
}