terraform {
  backend "s3" {
    bucket         = "tf-state-danit-devops-9"
    key            = "eks/terraform.tfstate"
    encrypt        = true
    region         = "eu-central-1"
    dynamodb_table = "lock-tf-eks"
    # dynamo key LockID
    #profile = 
  }
}
