# outputs.tf - v1.0 - Provision Minecraft EC2
# Updated 6/9/2025 Sophia Bouck
output "minecraft_server_ip" {
  value = aws_instance.minecraft.public_ip
}