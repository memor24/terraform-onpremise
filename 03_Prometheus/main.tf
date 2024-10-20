#creating docker network
resource "docker_network" "prometh_network" {
  name = "prometheus_network"
}

# creating the image seperately to make sure it is also managed by terraform
# this is how images are created in kreuzwerker/docker
data "docker_registry_image" "prometh_image" {
  name = "prom/prometheus:latest"
}
resource "docker_image" "prometh_image" {
  name          = data.docker_registry_image.prometh_image.name
  pull_triggers = [data.docker_registry_image.prometh_image.sha256_digest]
}

#creating prometheus container
resource "docker_container" "prometh_container" {
  name  = "prometheus_container"
  image = docker_image.prometh_image.name

  #port binding
  ports {
    internal = 9090
    external = var.prom_port
  }
  #container volume for persistent prometheus data
  volumes {
    host_path      = "/etc/prometheus/prometheus.yml"
    container_path = "/etc/prometheus"
  }
  #attaching container to network
  networks_advanced {
    name = docker_network.prometh_network.name
  }
  restart = "always"
}
########
variable "prom_port" {
  default = 9090
  type    = number
}
##############

output "prometheus_url" {
  value = "http://localhost:9090"
}
