terraform {
  required_version = ">= 0.13" #">= 1.9.7"

required_providers { 
  postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.12.0"
  }
}
}

#provider for 1 server;
provider "postgresql" {
  host     = var.host
  port     = var.port
  database = "postgres"
  username = var.username
  password = var.password
  sslmode  = "disabled" #or require/verify-ca/verify-full

}
