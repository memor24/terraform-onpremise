#creating a postgres database called test
resource "postgresql_database" "test" {
  name  = "test"
  owner = "DevOps_Team"
}

#revoking public access to default proivileges
resource "postgresql_default_privileges" "revoke_public" {
  database    = "test"
  role        = "public"
  owner       = "app_web"
  object_type = "function"
  privileges  = ["EXECUTE"]
}

########################
#postgres schema 
########################
resource "postgresql_schema" "my_schema" {
  name  = "my_schema"
  owner = "app_dba"
}

#creating the dba role that owns the schema
resource "postgresql_role" "app_dba" {
  name = "app_dba"
}
#app_dba policy:
resource "postgresql_grant" "app_dba" {
  role               = "app_dba"
  database           = "test"
  schema             = "my_schema"
  object_type        = "schema"
  privileges         = ["CREATE", "USAGE"]
  with_grant_option = true
}

#####################################
# postgres roles (dba, devops, web) # 
#####################################

resource "postgresql_role" "app_web" {
  name = "app_web"
}
#app_web policy:
resource "postgresql_grant" "grant_app_web" {
  role        = "app_web"
  database    = "test"
  schema      = "my_schema"
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE"]
}

resource "postgresql_role" "app_devops" {
  name = "app_devops"
}
#app_devops policy:
resource "postgresql_grant" "grant_app_devops" {
  role        = "app_devops"
  database    = "test"
  schema      = "my_schema"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]
}