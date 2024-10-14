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

#################
#postgres schema 
#################
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

  # app_releng can create new objects in the schema. 
  # this is the role that migrations are executed as:
  policy {
    role   = postgresql_role.app_releng.name
    create = true
    usage  = true
  }

  policy {
    create_with_grant = true
    usage_with_grant  = true
    role              = postgresql_role.app_dba.name
  }
}

##############
#data sources
##############
data "postgresql_schemas" "my_schemas" {
  database = "test_db"
}