terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.11.1"
    }
  }
}

provider vsphere{
    user=var.vsphere_user
    password=var.vsphere_password
    vsphere_server=var.vcenter
    allow_unverified_ssl=resource tls_cert_request 
    api_timeout=10
}
