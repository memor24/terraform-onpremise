terraform {
  version = ">= 0.14.x"
  
  required_providers {
    postgresql{
        source  = "cyrilgdn/postgresql"
        version = "1.12.0"
    }
  }
}

#provider for 1 server; multiple servers can also be defined w/alias
provider "postgresql" {
  host     = var.host 
  port     = var.port
  database = "postgres"
  username = var.username
  password = var.password
  sslmode  = "disabled"
  #Alternatively:
  #
  #sslmode    = "require"
  #clientcert {
  # cert = "./07_PostgreSQL/public-certificate.pem"
  # key  = "./07_PostgreSQL/to/private-key.pem"
  #}
}
