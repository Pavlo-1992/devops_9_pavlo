variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "ssh_key" {
  type        = string
}

variable "working_dir" {
  type        = string
}

variable "ami_id" {
  type        = string 
}

variable "instance_type" {
  type        = string
}

variable "volume_size" {
  type        = number 
}

variable "spot_price" {
  type        = string 
}