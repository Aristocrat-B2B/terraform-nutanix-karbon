locals {
  cp_host_inventory = zipmap(
    data.nutanix_karbon_cluster.cluster.master_node_pool[0].nodes.*.hostname,
    [for vm in data.nutanix_karbon_cluster.cluster.master_node_pool[0].nodes :
      {
        # Unfortunately it's impossible to grap uuid of a node
        ip = vm.ipv4_address
      }
    ]
  )
  etcd_host_inventory = zipmap(
    data.nutanix_karbon_cluster.cluster.etcd_node_pool[0].nodes.*.hostname,
    [for vm in data.nutanix_karbon_cluster.cluster.etcd_node_pool[0].nodes :
      {
        ip = vm.ipv4_address
      }
    ]
  )
  worker_host_inventory = zipmap(
    data.nutanix_karbon_cluster.cluster.worker_node_pool[0].nodes.*.hostname,
    [for vm in data.nutanix_karbon_cluster.cluster.worker_node_pool[0].nodes :
      {
        ip = vm.ipv4_address
      }
    ]
  )
}

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster_name
}

data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}

data "nutanix_karbon_cluster_kubeconfig" "configbyid" {
  karbon_cluster_id = nutanix_karbon_cluster.cluster1.id
  depends_on        = [nutanix_karbon_cluster.cluster1]
}

data "nutanix_karbon_cluster_ssh" "sshbyid" {
  karbon_cluster_id = nutanix_karbon_cluster.cluster1.id
  depends_on        = [nutanix_karbon_cluster.cluster1]
}

resource "nutanix_karbon_cluster" "cluster1" {
  name    = var.karbon_cluster_name
  version = var.kubernetes_version

  storage_class_config {
    name           = var.storage_class_config_name
    reclaim_policy = var.storage_class_config_reclaimPolicy
    volumes_config {
      file_system                = var.storage_class_config_volumeConfig_fileSystem
      password                   = var.storage_class_config_password
      username                   = var.storage_class_config_username
      prism_element_cluster_uuid = data.nutanix_cluster.cluster.metadata.uuid
      storage_container          = var.storage_class_config_storageContainer
    }
  }

  etcd_node_pool {
    node_os_version = var.node_os_version
    num_instances   = var.etcd_node_pool_numInstances
    ahv_config {
      cpu                        = var.etcd_node_pool_ahvConfig_cpu
      memory_mib                 = var.etcd_node_pool_ahvConfig_memory
      disk_mib                   = var.etcd_node_pool_ahvConfig_disk
      network_uuid               = data.nutanix_subnet.subnet.metadata.uuid
      prism_element_cluster_uuid = data.nutanix_cluster.cluster.metadata.uuid
    }
  }

  dynamic "active_passive_config" {
    for_each = var.external_ipv4_address != "" && var.master_node_pool_numInstances > 1 ? ["1"] : []
    content {
      external_ipv4_address = var.external_ipv4_address
    }
  }

  master_node_pool {
    node_os_version = var.node_os_version
    num_instances   = var.master_node_pool_numInstances
    ahv_config {
      cpu                        = var.master_node_pool_ahvConfig_cpu
      memory_mib                 = var.master_node_pool_ahvConfig_memory
      disk_mib                   = var.master_node_pool_ahvConfig_disk
      network_uuid               = data.nutanix_subnet.subnet.metadata.uuid
      prism_element_cluster_uuid = data.nutanix_cluster.cluster.metadata.uuid
    }
  }

  worker_node_pool {
    node_os_version = var.node_os_version
    num_instances   = var.worker_node_pool_numInstances
    ahv_config {
      cpu                        = var.worker_node_pool_ahvConfig_cpu
      memory_mib                 = var.worker_node_pool_ahvConfig_memory
      disk_mib                   = var.worker_node_pool_ahvConfig_disk
      network_uuid               = data.nutanix_subnet.subnet.metadata.uuid
      prism_element_cluster_uuid = data.nutanix_cluster.cluster.metadata.uuid
    }
  }

  cni_config {
    pod_ipv4_cidr     = var.cni_config_pod_ipv4_cidr
    service_ipv4_cidr = var.cni_config_service_ipv4_cidr
    calico_config {
      ip_pool_config {
        cidr = var.cni_config_pod_ipv4_cidr
      }
    }
  }

  lifecycle {
    ignore_changes = [storage_class_config]
  }
}
