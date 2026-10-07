provider "aws" {
  region = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "terraform-test-instance1"
}

resource "aws_instance" "example" {
  ami           = "ami-03e9149278a6f457c"
  instance_type = "t2.nano"

  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
