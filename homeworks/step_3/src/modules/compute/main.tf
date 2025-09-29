########################################
#                SG                    #
########################################

resource "aws_security_group" "step3_public" {
  name        = "step3_public"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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

  tags = { Name = "step3" }
}

resource "aws_security_group" "step3_private" {
  name        = "step3_private"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from master"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.step3_public.id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
#            Ubuntu instances (master-public, worker - private)                #
################################################################################

resource "aws_instance" "jenkins_master" {
  ami                 = var.ami_id
  instance_type       = var.instance_type
  subnet_id           = var.public_subnet_ids[0]
  vpc_security_group_ids  = [aws_security_group.step3_public.id]
  


  root_block_device {
    volume_size        = var.volume_size
  }
  
  user_data = <<-EOF
              #!/bin/bash
              echo "${var.ssh_key}" >> /home/ubuntu/.ssh/authorized_keys
              EOF

  tags = {
    Name = "jenkins_master"
  }
}

resource "aws_instance" "jenkins_worker" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.step3_private.id]

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = var.spot_price
      instance_interruption_behavior = "terminate" 
    }
  }

  root_block_device {
    volume_size        = var.volume_size
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "${var.ssh_key}" >> /home/ubuntu/.ssh/authorized_keys
    EOF
  tags = {
    Name = "jenkins_worker"
  }
}

######################################################
#       Automatic Ansible inventory generation       #
######################################################

resource "null_resource" "ansible_inventory_generator" {
  depends_on = [
    aws_instance.jenkins_master,
    aws_instance.jenkins_worker
  ]

  provisioner "local-exec" {
    command = <<-EOT
      echo "[jenkins_master]" > hosts.txt
      echo "jenkins_master ansible_host=${aws_instance.jenkins_master.public_ip}" >> hosts.txt
      echo "" >> hosts.txt
      echo "[jenkins_worker]" >> hosts.txt
      echo "jenkins_worker ansible_host=${aws_instance.jenkins_worker.private_ip} ansible_ssh_common_args='-o ProxyJump=ubuntu@${aws_instance.jenkins_master.public_ip}'" >> hosts.txt
    EOT
    working_dir = var.working_dir
  }
}
