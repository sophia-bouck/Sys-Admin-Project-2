# variables.tf - v1.0 - Provision Minecraft EC2
# Updated 6/9/2025 Sophia Bouck
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
}
