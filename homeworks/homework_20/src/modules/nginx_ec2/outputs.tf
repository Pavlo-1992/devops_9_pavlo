#outputs.tf

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.nginx_instance.public_ip
}
