#store the actual values in terraform.tfvars or in HC-Vault encrypted

variable "username" {
  default = "postgres"
  type    = string
}

variable "password" {
  default   = "postgres"
  type      = string
  sensitive = true
}