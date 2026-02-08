resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "8byte-assignment-vpc"
  }
}
resource "aws_subnet" "app_public_subnet" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = {
    Name = "8byte-assignment-subnet"
  }
}
resource "aws_internet_gateway" "app_internet_gateway" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "8byte-internet-gateway"
  }
}
resource "aws_route_table" "app_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_internet_gateway.id
  }
  tags = {
    Name = "8byte-assignment-public-route-table"
  }
}
resource "aws_route_table_association" "app_route_table_association" {
  subnet_id      = aws_subnet.app_public_subnet.id
  route_table_id = aws_route_table.app_route_table.id
}
resource "aws_security_group" "app_security_group" {
  name   = "8byte-assignment-sg"
  vpc_id = aws_vpc.app_vpc.id
  ingress {
    description = "For SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "For app"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "8byte-assignment-sg"
  }
}
data "aws_ami" "ubuntu_image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
resource "aws_instance" "app_ec2instance" {
  ami                         = data.aws_ami.ubuntu_image.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.app_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.app_security_group.id]
  key_name                    = var.ec2_ssh_key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu
    EOF
  tags = {
    Name = "8byte-assignment-ec2"
  }
}