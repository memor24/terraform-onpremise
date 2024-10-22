
# Resources:

#creating a docker network
resource "docker_network" "monitoring_network" {
  name = var.monitoring_network
  driver="bridge"
}

# creating the image seperately to make sure it is also managed by terraform
# this is how images are created in kreuzwerker/docker
data "docker_registry_image" "grafana_image" {
  name = "grafana/grafana:latest"
}
resource "docker_image" "grafana_image" {
  name          = data.docker_registry_image.grafana_image.name
  pull_triggers = [data.docker_registry_image.grafana_image.sha256_digest]
}

#create a grafana container
resource "docker_container" "graf_container" {
  name  = "grafana_container"
  image = docker_image.grafana_image.name

  #define ports
  ports {
    internal = 3000
    external = 3000
  }
  #mount volumes
  volumes {
    host_path      = "/var/lib/grafana"
    container_path = "/var/lib/grafana"
  }
  #connect the container to the network
  networks_advanced {
    name = docker_network.graf_network.name
  }
  #container auto restart policy
  restart = "always"
}


# Outputs:
output "grafana_url" {
  value = "http://localhost:3000"
}


# ##data sources:
# data "grafana_cloud_ips" "test" {}