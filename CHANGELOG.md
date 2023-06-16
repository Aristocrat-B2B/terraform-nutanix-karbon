# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

<a name="v2.0.1"></a>
## [v2.0.1] - 2023-06-16

Added
- Added the name of etcd node pool
- Added the name of master node pool
- Added the name of worker node pool

<a name="v2.0.0"></a>
## [v2.0.0] - 2023-05-19

Change
- `worker_nodes` output var now returns map which has following structure:
```
{
  host_name = {
    ip = "1.2.3.4"
  }
}
```
- added `cp_nodes` and `etcd_nodes` output vas with the same structure which return Control Plane nodes and etcd nodes
- added `host_inventory` which returns all Karbon nodes merged

<a name="v1.0.6"></a>
## [v1.0.6] - 2021-10-06

Change
- Add lifecycle ignore rule for storage_class_config

<a name="v1.0.5"></a>
## [v1.0.5] - 2021-07-05

Change
- Force all Karbon clusters to be Calico

<a name="v1.0.4"></a>
## [v1.0.4] - 2021-05-25

Added
- Added new output to list karbon worker nodes hostname:ip

<a name="v1.0.3"></a>
## [v1.0.3] - 2021-05-25

Added
- Added support for k8s multi master

<a name="v1.0.2"></a>
## [v1.0.2] - 2021-05-19

Added
- new outputs karbon_kubernetes_kubeconfig and karbon_kubernetes_sshconfig


<a name="v1.0.1"></a>
## [v1.0.1] - 2021-05-13

Changed
- Updated README.md


<a name="v1.0.0"></a>
## [v1.0.0] - 2021-04-28

Added
- Initial version of Karbon module

[Unreleased]: https://github.com/Aristocrat-B2B/terraform-nutanix-karbon/compare/v1.0.0...HEAD
