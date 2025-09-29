output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.network.private_subnet_ids
}

output "jenkins_master_id" {
  description = "The ID of the Jenkins master EC2 instance."
  value       = module.compute.jenkins_master_id
}

output "jenkins_worker_id" {
  description = "The ID of the Jenkins worker EC2 instance."
  value       = module.compute.jenkins_worker_id
}