variable "profile" {
  type    = string
  default = "terraform"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "tfstate_bucket_name" {
  type    = string
  default = "tfstate-bucket-spv"
}
