#main.tf

# Знаходимо першу доступну subnet у вказаній VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Security Group у вказаній VPC
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.list_of_open_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 у першій subnet цієї VPC
resource "aws_instance" "nginx_instance" {
  ami                    = "ami-0a116fa7c861dd5f9" 
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.selected.ids[0] # <-- беремо першу subnet
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true


  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:80 nginx
              EOF

  tags = {
    Name = "nginx-ec2"
   #Ovner = "Pavlo"
  }
}
