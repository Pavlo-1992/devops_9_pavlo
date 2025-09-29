###########################################
#   S3 bucket for terraform state file    #
###########################################

provider "aws" {
  region    = var.region
  profile   = var.profile
}

terraform {
    required_version = ">= 1.5.0"
   backend "s3" {
    profile = "terraform"
    bucket  = "tfstate-bucket-spv"
    key     = "terraform/terraform_spv.tfstate"
    region  = "eu-central-1"
    encrypt = true
   }
}
   
###################
#   Create VPS    #
###################

module "network" {
  source               = "./modules/network"
  name                 = var.name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

########################
#   Create instanse    #
########################

module "compute" {
  source               = "./modules/compute"
  vpc_id               = module.network.vpc_id
  public_subnet_ids    = module.network.public_subnet_ids
  private_subnet_ids   = module.network.private_subnet_ids
  ssh_key              = var.ssh_key
  working_dir          = var.working_dir
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  volume_size          = var.volume_size
  spot_price           = var.spot_price
}
 
