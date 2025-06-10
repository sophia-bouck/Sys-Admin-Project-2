# Sys-Admin-Project-2
System Administration Course Project Part 2
Author: Sophia Bouck

## Background
This project automates the provisioning and configuration of a dedicated Minecraft server in AWS. 

Using Terraform and Ansible, the system creates an EC2 instance and configures it to run a Minecraft server. All configuration steps are scripted and repeatable, making it easy to deploy or redeploy the server at any time.

## Requirements
To run this project, you need:

### Tooling

- [Terraform](https://developer.hashicorp.com/terraform/downloads) ≥ 1.3
- [Ansible](https://docs.ansible.com/) ≥ 2.14
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- A Unix-like terminal (macOS, Linux, or WSL)
- A configured EC2 key pair for SSH access

### AWS Environment

- (After running Terraform this should be automatically added) A running EC2 instance (Amazon Linux 2023) in a public subnet
- (After running Terraform this should be automatically added, good to check if troubleshooting) Security Group with **TCP port 25565** open to your IP or 0.0.0.0/0
- `LabInstanceProfile` (attached during EC2 launch)

### Configuration

- Add your private key path and instance IP to `inventory.ini`

## How to Run
1. Clone the repository
`git clone https://github.com/yourusername/sys-admin-project-2.git` 
`cd sys-admin-project-2`
2. Run Terraform
`cd terraform terraform init terraform apply`
Copy down the ip that is returned to add it to **inventory.ini** in the following step
3. Configure the Ansible inventory
Edit the **inventory.ini** file and replace the placeholder values:
`[minecraft] <your-ec2-public-ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh your-key.pem ansible_python_interpreter=/usr/bin/python3.8`
4. Run the Ansible playbook
`ansible-playbook -i inventory.ini playbook.yml`

## How to Connect
1. (optional) Use nmap to verify the server is open
Run the following command locally:
`nmap -sV -Pn -p T:25565 <your-ec2-public-ip>`
2. Open Minecraft: Java Edition
3. Click Multiplayer
4. Click Add Server
5. Enter a name and your EC2 public IP
6. Click Done
7. Select the server from the list and click Join Server

## Pipeline Diagram
```text
+-------------+       +-------------------+       +------------------------+
| Developer   |  -->  | Ansible Controller |  -->  | EC2 Minecraft Instance |
+-------------+       +-------------------+       +------------------------+
         |                          |                        |
         |      Run playbook        |      Install Java      |
         |------------------------->|------------------------>|
         |                          |      Download Minecraft |
         |                          |      Accept EULA        |
         |                          |  Setup systemd service  |
         |                          |------------------------>|
         |                          |    Minecraft running    |
         |<-------------------------|<------------------------|
