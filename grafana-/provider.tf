terraform {
  required_version = ">= 0.12"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">=1.0.0"
    }
  }
}


provider "grafana" {
  url  = "http://localhost:3000" # or "http://grafana.example.com/"
  auth = var.grafana_auth
}

variable "grafana_auth" { #store the actual values in terraform.tfvars or Vault
  default = "admin:admin"
}
