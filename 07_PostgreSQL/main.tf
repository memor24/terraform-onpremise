resource "postgresql_database" "test" {
  name  = "test"
  owner = "DevOps"
}

#revoking public access to default proivileges
resource "postgresql_default_privileges" "revoke_public" {
  database    = "postgresql_database.test.name"
  role        = "public"
  owner       = "DevOps"
  object_type = "function"
  privileges  = ["EXECUTE"]
  }

########################
#postgres roles & schema 
########################
resource "postgresql_role" "app_web" {
  name = "app_www"
    policy {
    role  = postgresql_role.app_web.name
    usage = true
  }
}

resource "postgresql_role" "app_devops" {
  name = "app_devops"
}
resource "postgresql_grant" "grant_app_devops" {
    role  = "postgresql_role.app_devops.name"
    database="test"
    schema= "postgresql_schema.my_schema.name"
    object_type= "schema"
    privileges=["CREATE","USAGE"]
  }

resource "postgresql_role" "app_dba" {
  name = "app_dba"
}
#defining the schema itself
resource "postgresql_schema" "my_schema" {
  name  = "my_schema"
  owner = "app_dba"
}

##############
#data sources
##############
# data "postgresql_schemas" "my_schemas" {
#   database = "test"
# }