# terraform-nutanix-karbon

A terraform module to create a managed Kubernetes cluster on Nutanix. Available
through the [Terraform registry](https://registry.terraform.io/modules/terraform-nutanix-karbon).

## Assumptions

* You want to create a Nutanix Karbon Kubernetes cluster that has valid default values for just about everything.

## Important note

The `kubernetes_version` is a required variable. Kubernetes is evolving a lot, and each major version includes new features, fixes, or changes.

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**

## Usage example

A full example leveraging other community modules is contained in the [examples/](https://github.com/Aristocrat-B2B/terraform-nutanix-karbon/tree/master/examples/).

```hcl

terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.0"
    }
  }
}

provider "nutanix" {
  username = "admin"
  password = "ItsASecret!"
  endpoint = "10.0.0.10" # prism endpoint
  insecure = true
}

module "karbon" {
  source                            = "terraform-nutanix-karbon"
  version = "1.0.3"
  karbon_cluster_name               = "test-karbon-cluster"
  storage_class_config_username     = "admin"
  storage_class_config_password     = "SecretPassword!"
  nutanix_cluster_name              = "my-cluster"
  subnet_name                       = "my-subnet"
}

```

## Kubectl config
To get access to the kubectl config, simply create an output like :

```hcl
output "kubectl_cfg" {
  value     = module.karbon.karbon_kubernetes_kubeconfig
  sensitive = true
}
```

and then you can use it in scripts by running:

```hcl
terraform output -raw kubectl_cfg
```

This will correctly output a valid kubectl.cfg file - that can be stored to disk and used.

## Conditional creation

Sometimes you need to have a way to create resources conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create_karbon`.


```hcl

# This cluster will not be created
module "karbon" {
  source                            = "terraform-nutanix-karbon"
  version                           = "1.0.3"
  create_karbon                     = false
  karbon_cluster_name               = "test-karbon-cluster"
  storage_class_config_username     = "admin"
  storage_class_config_password     = "SecretPassword!"
  nutanix_cluster_name              = "my-cluster"
  subnet_name                       = "my-subnet"
}
```

## Multi master nodes
If you want to have more than one (recommended is two for production), master k8s nodes then you need to set the variable `external_ipv4_address` to be an IP in your subnet range.
For example:

```
module "karbon" {
  source                            = "terraform-nutanix-karbon"
  version                           = "1.0.3"
  karbon_cluster_name               = "test-karbon-cluster"
  storage_class_config_username     = "admin"
  storage_class_config_password     = "SecretPassword!"
  nutanix_cluster_name              = "my-cluster"
  subnet_name                       = "my-subnet"

  master_node_pool_numInstances         = 2
  master_node_pool_ahvConfig_cpu        = 4 # number of master nodes * X
  master_node_pool_ahvConfig_memory     = 4096
  master_node_pool_ahvConfig_disk       = 122880
  external_ipv4_address                 = "10.100.4.99"
}
```


## Troubleshooting Note

If the cluster creation status is stuck at 8% with progress_message as "ETCD deployment started", please review the storage container that you entered exists in the prism element.

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/Aristocrat-B2B/terraform-nutanix-karbon/issues/new) section.

Full contributing [guidelines are covered here](https://github.com/Aristocrat-B2B/terraform-nutanix-karbon/blob/master/.github/CONTRIBUTING.md).

## Change log

- The [changelog](https://github.com/Aristocrat-B2B/terraform-nutanix-karbon/tree/master/CHANGELOG.md) captures all important release notes from v1.0.0

## Authors

- Created by [B2B Devops - Aristocrat](https://github.com/Aristocrat-B2B)
- Maintained by [B2B Devops - Aristocrat](https://github.com/Aristocrat-B2B)

## License

MIT Licensed. See [LICENSE](https://github.com/Aristocrat-B2B/terraform-nutanix-karbon/tree/master/LICENSE) for full details.


