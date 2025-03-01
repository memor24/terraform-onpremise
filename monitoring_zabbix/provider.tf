terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.11.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vcenter
  allow_unverified_ssl = true
  api_timeout          = 10
}

provider "null" {}
