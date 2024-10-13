terraform {
  required_version = ">= 0.12"

required_providers {
│     docker = {
│       source = "kreuzwerker/docker"
│     }
}
}

resource "docker_container" "grafana" {
image= "grafana/grafana:latest"
name= "grafana"
restart= "always"
ports {
    internal=3000
    external=var.grafana_port
}
network_advanced {
    name=var.network_name
}
}

# instead of outputs.tf
output grafana_url {
  value       = "http://localhost.${grafana_port}"
  }
