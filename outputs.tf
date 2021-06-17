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

data "nutanix_karbon_cluster" "cluster" {
  karbon_cluster_id = nutanix_karbon_cluster.cluster1.id
}

output "worker_nodes" {
  description = "List of Karbon worker nodes hostname:ip"
  value       = zipmap(local.work_node_names, data.nutanix_karbon_cluster.cluster.worker_node_pool[0].nodes.*.ipv4_address)
}
