# Resources:

# Creating the organization (On-premise, not supported in Grafana Cloud)
resource "grafana_organization" "my_org" {
  name = "my_org"
}

# creating folder and its permission
resource "grafana_folder" "org_folder" {
  org_id = grafana_organization.my_org.org_id
  title  = "test folder"
}
resource "grafana_folder_permission" "org_permission" {
  folder_uid = grafana_folder.org_folder.uid
  permissions {
    role       = "Editor"
    permission = "Edit"
  }
}

# creating dashboard
resource "grafana_dashboard" "org_dashboard" {
  org_id = grafana_organization.my_org.org_id
  folder = grafana_folder.org_folder.id
  config_json = jsonencode({
    "title" : "My Dashboard Title",
    "uid" : "my-dashboard-uid"
  })
}

# defining the data source
resource "grafana_data_source" "prometheus" {
  name = "Prometheus"
  type = "prometheus"
  url  = "http://prometheus:9090"
}
