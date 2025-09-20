### File           : terraform
### Description    : Launch 2 EC2
### Author         : Pavlo Savanchuk
### Version        : 1.0
### Date           : 2025-09-20

provider "aws" {
  region = "eu-west-1"
}

# --- Put your SSH public keys here ---
locals {
  # Primary public key (used for all instances)
  ssh_key_primary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4XvOgdPUO8j2G+L3iKRS3xrT/vUEJ2BfOzBQIgg/iR ansible"
  ssh_key_name    = "ansible-demo-key"
}

# ------------------------------
# Default VPC + a simple SG
# ------------------------------
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web" {
  name        = "ansible-demo-sg"
  description = "Allow SSH/HTTP/HTTPS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # TIP: narrow to your IP in real use
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-ansible-demo" }
}

# ------------------------------
# Key pair from embedded public key
# ------------------------------
resource "aws_key_pair" "primary" {
  key_name   = local.ssh_key_name
  public_key = local.ssh_key_primary
}


# ------------------------------
# 2 × Ubuntu instances
# ------------------------------
resource "aws_instance" "ubuntu" {
  count                  = 2
  ami                    = "ami-0bc691261a82b32bc"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.primary.key_name
  vpc_security_group_ids = [aws_security_group.web.id]
  # default subnet in the default VPC will be auto-selected
  associate_public_ip_address = true

  tags = {
    Name = "ubuntu-${count.index}"
  }
}

# --- Automatic Ansible inventory generation ---
resource "null_resource" "ansible_inventory_file" {
  depends_on = [aws_instance.ubuntu]

  provisioner "local-exec" {
    command = <<-EOT
      echo "[web_server]" > hosts.txt
      echo "${aws_instance.ubuntu[0].public_ip}" >> hosts.txt
      echo "${aws_instance.ubuntu[1].public_ip}" >> hosts.txt
    EOT
    working_dir = path.module
  }
}
