# AWS account config
region = "eu-central-1"

# General for all infrastructure
# This is the name prefix for all infra components
name = "danit"


vpc_id = "vpc-0de3c0859746a564a"
subnets_ids = ["subnet-09aed3e8d25474fe6", "subnet-0517b545ebcbf26fe", "subnet-0cbe4562bfc4883fd"]


tags = {
  Environment = "test"
  TfControl   = "true"
}


zone_name = "devops9.test-danit.com"
