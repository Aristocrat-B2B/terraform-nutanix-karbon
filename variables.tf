# Required Variables
variable "kubernetes_version" {
  type        = string
  description = "K8s version of the cluster"
}

variable "nutanix_cluster_name" {
  type        = string
  description = "The name of the nutanix cluster"
}

variable "subnet_name" {
  type        = string
  description = "The name of the nutanix subnet to deploy into"
}

variable "node_os_version" {
  type        = string
  description = "The version of the node OS image"
}

# Optional Variables
variable "create_karbon" {
  type        = bool
  description = "Controls if Karbon resource should be created"
  default     = true
}

variable "karbon_cluster_name" {
  type        = string
  description = "The name for the k8s cluster."
  default     = "karbon-cluster"
}

variable "storage_class_config_name" {
  type        = string
  description = "The name of the storage class"
  default     = "default-storageclass"
}

variable "storage_class_config_reclaimPolicy" {
  type        = string
  description = "Reclaim policy for persistent volumes provisioned using the specified storage class"
  default     = "Delete"
}

variable "storage_class_config_volumeConfig_fileSystem" {
  type        = string
  description = " Karbon uses either the ext4 or xfs file-system on the volume disk"
  default     = "ext4"
}

variable "storage_class_config_username" {
  type        = string
  description = "Username of the Prism Element user that the API calls use to provision volumes"
  default     = "admin"
}

variable "storage_class_config_password" {
  type        = string
  description = "The password of the Prism Element user that the API calls use to provision volumes"
  default     = "its_a_secret!"
}

variable "storage_class_config_storageContainer" {
  type        = string
  description = "Name of the storage container the storage container uses to provision volumes"
  default     = "Default"
}

variable "etcd_node_pool_numInstances" {
  type        = number
  description = "Number of nodes in the etcd node pool"
  default     = 1
}

variable "etcd_node_pool_ahvConfig_cpu" {
  type        = number
  description = "The number of Vcpus allocated to each VM on the PE cluster"
  default     = 4
}

variable "etcd_node_pool_ahvConfig_memory" {
  type        = number
  description = "Memory allocated for each VM on the PE cluster in MiB"
  default     = 8192
}

variable "etcd_node_pool_ahvConfig_disk" {
  type        = number
  description = "Size of local storage for each VM on the PE cluster in MiB"
  default     = 40960
}

variable "master_node_pool_numInstances" {
  type        = number
  description = "Number of nodes in the master node pool"
  default     = 1
}

variable "master_node_pool_ahvConfig_cpu" {
  type        = number
  description = "The number of Vcpus allocated to each VM on the PE cluster"
  default     = 2
}

variable "master_node_pool_ahvConfig_memory" {
  type        = number
  description = "Memory allocated for each VM on the PE cluster in MiB"
  default     = 4096
}

variable "master_node_pool_ahvConfig_disk" {
  type        = number
  description = "Size of local storage for each VM on the PE cluster in MiB"
  default     = 122880
}

variable "worker_node_pool_numInstances" {
  type        = number
  description = "Number of nodes in the worker node pool"
  default     = 1
}

variable "worker_node_pool_ahvConfig_cpu" {
  type        = number
  description = "The number of Vcpus allocated to each VM on the PE cluster"
  default     = 8
}

variable "worker_node_pool_ahvConfig_memory" {
  type        = number
  description = "Memory allocated for each VM on the PE cluster in MiB"
  default     = 8192
}

variable "worker_node_pool_ahvConfig_disk" {
  type        = number
  description = "Size of local storage for each VM on the PE cluster in MiB"
  default     = 122880
}

variable "cni_config_pod_ipv4_cidr" {
  type        = string
  description = "CIDR for pods in the cluster"
  default     = "172.19.0.0/16"
}

variable "cni_config_service_ipv4_cidr" {
  type        = string
  description = "Classless inter-domain routing (CIDR) for k8s services in the cluster"
  default     = "172.20.0.0/16"
}
