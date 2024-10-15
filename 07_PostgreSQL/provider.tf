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

# Bash script to check PostgreSQL status and configuration
resource "null_resource" "check_postgresql" {
  provisioner "local-exec" {
    command = <<EOT
    #!/bin/bash

    # Check if PostgreSQL is installed
    if ! command -v psql >/dev/null 2>&1; then
      echo "PostgreSQL is not installed. Installing PostgreSQL..."
      sudo apt update
      sudo apt install -y postgresql postgresql-contrib
    else
      echo "PostgreSQL is already installed."
    fi

    # Check if PostgreSQL is running
    if ! systemctl is-active --quiet postgresql; then
      echo "PostgreSQL is not running. Starting PostgreSQL..."
      sudo systemctl start postgresql@14-main
    else
      echo "PostgreSQL is already running."
    fi

    # Temporarily switch to peer authentication for postgres user
    echo "Switching to peer authentication temporarily..."
    sudo sed -i 's/^local\s\+all\s\+postgres\s\+md5/local all postgres peer/' /etc/postgresql/14/main/pg_hba.conf
    sudo systemctl restart postgresql@14-main

    # Change the password for the postgres user
    echo "Setting a new password for the postgres user..."
    sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';" # Replace 'new_password' with your desired password
    echo "Password has been updated."

    # Exit PostgreSQL and exit script
    echo "\\q" | sudo -u postgres psql
    exit

    # Switch back to md5 authentication
    echo "Switching back to md5 authentication..."
    sudo sed -i 's/^local\s\+all\s\+postgres\s\+peer/local all postgres md5/' /etc/postgresql/14/main/pg_hba.conf
    sudo systemctl restart postgresql@14-main

    echo "PostgreSQL configuration updated and md5 authentication re-enabled."
    echo "PostgreSQL configuration looks good!"
    EOT
  }
}
