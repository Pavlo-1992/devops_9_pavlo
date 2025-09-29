output "jenkins_master_id" {
  description = "The ID of the Jenkins master EC2 instance."
  value       = aws_instance.jenkins_master.id
}

output "jenkins_worker_id" {
  description = "The ID of the Jenkins worker EC2 instance."
  value       = aws_instance.jenkins_worker.id
}
