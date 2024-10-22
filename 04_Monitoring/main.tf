terraform {
  required_version = ">= 0.12"

  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

#monitoring network on docker(local/compose)
resource "docker_network" "monitoring_network" {
  name = var.monitoring_network
}

module "grafana" {
  source       = "./modules/grafana"
  network_name = docker_network.monitoring_network.name
}

module "prometheus" {
  source          = "./modules/prometheus"
  network_name    = docker_network.monitoring_network.name
}