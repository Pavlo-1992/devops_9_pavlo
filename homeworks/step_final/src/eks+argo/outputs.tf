output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.danit.name
}

output "eks_cluster_region" {
  description = "AWS region where the EKS cluster is deployed"
  value       = var.region
}

output "argocd_url" {
  description = "ArgoCD ingress URL"
  value       = "http://${local.argocd_domain}"
}
