# main.tf

provider "aws" {
  region = "eu-central-1"
}

module "nginx_ec2" {
  source           = "./modules/nginx_ec2"
  vpc_id           = var.vpc_id
  list_of_open_ports = var.list_of_open_ports
}

output "instance_public_ip" {
  value = module.nginx_ec2.instance_public_ip
}
