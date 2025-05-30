provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0e35ddab05955cf57"  # ubuntu linux
  instance_type = "t2.micro"
  key_name      = "terraform"          # Replace with your actual EC2 Key Pair name

  tags = {
    Name = "TerraformTestInstance"
  }
}
