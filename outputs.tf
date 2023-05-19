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
  description = "Map of Karbon worker nodes { hostname = { ip = <ip> }}"
  value       = local.worker_host_inventory
}

output "cp_nodes" {
  description = "Map of Karbon Control Plane master nodes { hostname = { ip = <ip> }}"
  value       = local.cp_host_inventory
}

output "etcd_nodes" {
  description = "Map of Karbon etcd nodes { hostname = { ip = <ip> }}"
  value       = local.etcd_host_inventory
}

output "host_inventory" {
  description = "Map which contains all Karbon nodes { hostname = { ip = <ip> }}"
  value       = merge(local.etcd_host_inventory, local.cp_host_inventory, local.worker_host_inventory)
}
