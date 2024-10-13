###TBU
terraform {
  version = 1.9
  required_providers {
    ###tbu
  }
}
###provider for 1 server; multiple servers can also be defined w/alias
provider "postgresql" {
  host     = var.host #or "postgres_server_ip"
  port     = var.port
  database = "postgres"
  username = var.username
  password = var.password
  sslmode  = "disabled"
  #Alternatively
  #sslmode         = "require"
  #clientcert {
  # cert = "./07_PostgreSQL/public-certificate.pem"
  # key  = "./07_PostgreSQL/to/private-key.pem"
  #}
}

resource "postgresql_database" "test_db" {
  name  = "test_db"
  owner = "DevOps_team"
}

#revoking public access to default proivileges
resource "postgresql_default_privileges" "revoke_public" {
  database    = postgresql_database.test_db.name
  role        = "public"
  owner       = "object_owner"
  object_type = "function"
  privileges  = []
}

#######################
#postgres schema 
#######################
resource "postgresql_role" "app_www" {
  name = "app_www"
}

resource "postgresql_role" "app_dba" {
  name = "app_dba"
}

resource "postgresql_role" "app_releng" {
  name = "app_releng"
}

resource "postgresql_schema" "my_schema" {
  name  = "my_schema"
  owner = "postgres"

  policy {
    usage = true
    role  = postgresql_role.app_www.name
  }

  # app_releng can create new objects in the schema.  This is the role that
  # migrations are executed as.
  policy {
    create = true
    usage  = true
    role   = postgresql_role.app_releng.name
  }

  policy {
    create_with_grant = true
    usage_with_grant  = true
    role              = postgresql_role.app_dba.name
  }
}
