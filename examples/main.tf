module "karbon" {
  source                            = "terraform-nutanix-karbon"
  version                           = "1.0.0"
  nutanix_cluster_name              = "my-nutanix-cluster"
  karbon_cluster_name               = "test-karbon-cluster"
  subnet_name                       = "my-subnet"
  storage_class_config_username     = "admin"
  storage_class_config_password     = "ItsASecret!"
  node_os_version                   = "ntnx-1.0"
  etcd_node_pool_numInstances       = 1
  etcd_node_pool_ahvConfig_cpu      = 4
  etcd_node_pool_ahvConfig_memory   = 8192
  etcd_node_pool_ahvConfig_disk     = 40960
  master_node_pool_numInstances     = 1
  master_node_pool_ahvConfig_cpu    = 2
  master_node_pool_ahvConfig_memory = 4096
  master_node_pool_ahvConfig_disk   = 122880
  worker_node_pool_numInstances     = 2
  worker_node_pool_ahvConfig_cpu    = 8
  worker_node_pool_ahvConfig_memory = 8192
  worker_node_pool_ahvConfig_disk   = 122880
  cni_config_pod_ipv4_cidr          = "172.19.0.0/16"
  cni_config_service_ipv4_cidr      = "172.20.0.0/16"
}

