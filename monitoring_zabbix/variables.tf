# setup

variable "vsphere_user" {
  description = "vSphere user name, defined in tfvars"
}

variable "vsphere_password" {
  description = "vSphere password, defined in tfvars, or injected as secret"
}

variable "vcenter" {
  description = "vCenter server IP, in tfvars"
}


## vm

variable "cpu"{
    default=1
}

variable "ram"{
    default=1024
}

