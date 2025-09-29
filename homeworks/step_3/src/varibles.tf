variable "profile" {
  type    = string
  default = "terraform"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "name" {
  description = "Name for VPC"
  type    = string
  default = "savanchuk_sp3"
}

variable "vpc_cidr" {
  description = "Cidr block for VPC"
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "List of aviabiluty zone"
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnet_cidrs" {
  description = "Cidr for public subnet"
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidrs" {
  description = "Cidr for private subnet"
  type    = string
  default = "10.0.11.0/24"
}

variable "ssh_key" {
  description = "Ssh public key for connect to instans in public subnet"
  type        = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4XvOgdPUO8j2G+L3iKRS3xrT/vUEJ2BfOzBQIgg/iR ansible"
}

variable "working_dir" {
  description = "Working dir for save ansible inventory file (host.txt)  after automatic generation"
  type        = string
  default = "/home/pavlo/hometask/step_3/ansible"
}

variable "ami_id" {
  description = "Ami id for ec2"
  type        = string
  default = "ami-0a116fa7c861dd5f9"
  
}
variable "instance_type" {
  description = "Instance type for ec2"
  type        = string
  default = "t2.medium"
}

variable "volume_size" {
  description = "Root volume size for ec2"
  type        = number
  default = 16
}

variable "spot_price" { 
  description = "Max price for spot instance"
  type        = string
  default = "0.1"
  
}
