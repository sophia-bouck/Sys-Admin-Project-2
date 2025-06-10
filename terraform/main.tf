# main.tf - v1.0 - Provision Minecraft EC2
# Updated 6/9/2025 Sophia Bouck
data "aws_iam_instance_profile" "lab" {
  name = "LabInstanceProfile"
}

resource "aws_instance" "minecraft" {
  ami                    = "ami-0c101f26f147fa7fd" # Amazon Linux 2023
  instance_type          = var.instance_type
  key_name               = var.key_name

  iam_instance_profile = data.aws_iam_instance_profile.lab.name

  tags = {
    Name = "minecraft-server"
  }
}
