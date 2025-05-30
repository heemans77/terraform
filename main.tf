provider "aws" {
  region = "ap-south-1"
}

# SECURITY GROUP
resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

# EC2 INSTANCE
resource "aws_instance" "my_ec2" {
  ami           = "ami-0e35ddab05955cf57"  # Ubuntu Linux
  instance_type = "t2.micro"
  key_name      = "terraform"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "TerraformTestInstance"
  }
}

# S3 BUCKET
resource "aws_s3_bucket" "terraform_bucket" {
  bucket        = "my-terraform-demo-bucket-2025-1"
  force_destroy = true

  tags = {
    Name = "TerraformBucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
