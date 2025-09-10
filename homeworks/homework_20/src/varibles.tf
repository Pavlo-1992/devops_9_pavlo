#varibles.tf

variable "vpc_id" {
  description = "ID of the VPC where EC2 and SG will be created"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of ports to open for inbound traffic"
  type        = list(number)
}
