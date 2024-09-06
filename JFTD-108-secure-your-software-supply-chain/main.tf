################### VARIABLES ##############################
variable "name" {
  type    = string
  default = "Terraform-state"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "region" {
  type = string
  default = "us-east-1"
}
################### PROVIDER ##############################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
################### EC2 INSTANCE ###########################
resource "aws_instance" "test" {
  ami                         = "ami-052efd3df9dad4825"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.test.name]
  tags = {
    Name = var.name
  }
}
################### SECURITY GROUP ##########################
resource "aws_security_group" "test" {
  name        = var.name
  description = "Allow TLS inbound traffic"
  ingress {
    description = "allow access to web"
    from_port   = 80
    to_port     = 80
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
    Name = var.name
  }
}
################### S3 BUCKET ##############################
resource "aws_s3_bucket" "b" {
  bucket = lower("${var.name}-test-bucket-state-file")
  force-destroy = true
}
resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
################### OUTPUTS ##############################
output "IpAddress" {
  value = aws_instance.test.public_ip
}
output "BucketName" {
  value = aws_s3_bucket.b.bucket
}