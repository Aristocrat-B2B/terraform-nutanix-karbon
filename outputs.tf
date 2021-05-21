output "karbon_cluster_name" {
  description = "The name of the Karbon cluster"
  value       = var.karbon_cluster_name
}

output "karbon_kubernetes_version" {
  description = "The kubernetes version"
  value       = var.kubernetes_version
}

output "karbon_kubernetes_kubeconfig" {
  description = "Kubeconfig settings for Karbon"
  value       = templatefile("${path.module}/kubectl.tmpl", data.nutanix_karbon_cluster_kubeconfig.configbyid)
  sensitive   = true
}

output "karbon_kubernetes_sshconfig" {
  description = "SSH config for Karbon"
  value       = data.nutanix_karbon_cluster_ssh.sshbyid
  sensitive   = true
}
