######################################
#                VPC                 #
######################################

resource "aws_vpc" "step3" {
  cidr_block  = var.vpc_cidr
  tags = { Name = "${var.name}-vpc" }
}

#######################################
#           Internet Gateway          #
#######################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.step3.id
  tags = { Name = "${var.name}-igw" }
}
#######################################
#          Public subnets             #
#######################################

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.step3.id
  cidr_block              = var.public_subnet_cidrs
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-${var.azs[0]}" }
}

#######################################
#          Private subnets            #
#######################################

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.step3.id
  cidr_block        = var.private_subnet_cidrs
  availability_zone = var.azs[1]
  tags = { Name = "${var.name}-private-${var.azs[1]}" }
}

#######################################
#             NAT Gateway             #
#######################################
 
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = { Name = "${var.name}-nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id  
  tags = { Name = "${var.name}-nat" }
}
#######################################
#    Route table for PUBLIC subnets   #
#######################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.step3.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
###########################################
# Route table for PRIVATE subnets (to NAT)#
###########################################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.step3.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "${var.name}-private-rt" }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
