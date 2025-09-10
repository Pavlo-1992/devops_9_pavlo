# backend.tf

terraform {
  backend "s3" {
    bucket = "terraform-state-danit-devops9"
    region = "eu-central-1"
    key    = "savanchuk/terraform.tfstate"
    profile = "terraform"
  }
}