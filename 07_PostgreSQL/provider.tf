terraform {
  required_version = ">= 0.13" #"= 1.9.7"

  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.12.0"
    }
  }
}

#provider for one server;
provider "postgresql" {
  host     = "127.0.0.1"
  port     = 5432
  database = "test"
  username = var.username
  password = var.password
  sslmode  = "disabled" #or require/verify-ca/verify-full
}

#bash script for the postgresql database config
resource "null_resource" "check_postgresql" {

  provisioner "local-exec" {
    command = <<EOF
    #check if posgres is running
    if ! systemctl --is-active postgresql; then
        echo "PostgreSQL is not running. Starting PostgreSQL..."
        sudo systemctl start postgresql@14-main
        echo "PostgreSQL is running!"
    else
        echo "PostgreSQL is already running!"
    fi

    EOF
  }
}
