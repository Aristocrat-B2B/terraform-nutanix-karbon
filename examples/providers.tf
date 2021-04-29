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

