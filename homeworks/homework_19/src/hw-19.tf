###File           : hw-19.tf
###Description    :script to hw
###Author         : Pavlo Savanchuk
###Version history:25.09.04
###Date           :1.0

#check the keys before starting  
provider "aws" {
    region  = "eu-central-1"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "hw19-vpc"                                                                               
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "hw-public-subnet"                                                                                
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "hw-igw"                                                                                 
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "hw-public-rt"                                                                          
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "public" {
  vpc_id      = aws_vpc.main.id
  name        = "public"
  description = "public SG"

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

#############################################################

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "hw-private-subnet"                                                                      
  }
}


# EIP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "hw-nat-eip"                                                                              
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "hw-nat-gw"                                                                              
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "hw-private-rt"                                                                          
  }
}


# Associate Route Table with Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Security Group
resource "aws_security_group" "private" {
  vpc_id      = aws_vpc.main.id
  name        = "private"
  description = "Private SG"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########################################################################

# EC2 Instance in Public Subnet
resource "aws_instance" "public_instance" {
  ami                    = "ami-0a116fa7c861dd5f9"
  instance_type          = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]
  associate_public_ip_address = true
  key_name = "savanchuk_frankfurt"  

  tags = {
    Name = "hw-public-instance"                                                                      
  }
}

# EC2 Instance in Private Subnet
resource "aws_instance" "private_instance" {
  ami                    = "ami-0a116fa7c861dd5f9"
  instance_type          = "t3.micro"
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]
  associate_public_ip_address = false
  key_name = "savanchuk_frankfurt"

  tags = {
    Name = "hw-private-instance"                                                                     
  }
}