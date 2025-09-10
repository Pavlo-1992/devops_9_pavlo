#outputs.tf 

output "nginx_url" {
  description = "URL to access Nginx"
  value       = "http://${module.nginx_ec2.instance_public_ip}"
}
