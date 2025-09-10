#varibles.tf

variable "vpc_id" {
  description = "VPC where EC2 will be launched"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of ports to open in security group"
  type        = list(number)
}


