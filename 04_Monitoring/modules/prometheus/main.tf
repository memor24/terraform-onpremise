terraform {
  required_version = ">= 0.12"

required_providers {
     docker = {
       source = "kreuzwerker/docker"
     }
}
}

resource "docker_container" "prometheus" {
image {"prometheus/prometheus:latest"}
name {"prometheus"}
restart {"always"}
ports{
internal=9090
external=var.prometheus_port
}

network_advanced {
name= var.network_name
}
}