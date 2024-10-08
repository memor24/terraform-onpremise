terraform {
  required_version = ">= 0.12"

required_providers {
│     docker = {
│       source = "kreuzwerker/docker"
│     }
}
}

#monitoring network on docker(compose)
resource "docker_network" "monitoring_network"{
    name="monitoring_network"
}

module "prometheus" {
    source="./modules/prometheus"
    network_name=docker_network.monitoring_network.name
    prometheus_port=var.prometheus_port
}

module "grafana" {
    source = "./modules/grafana"
    network_name=docker_network.monitoring_network.name
    grafana_port=var.grafana_port
}