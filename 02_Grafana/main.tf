

##########main:
#creating a docker network
resource "docker_network" "grafana_network" {
    name= "grafana_network"
}

#create a grafana container
resource "docker_container" "grafana_container" {
    name= "grafana_container"
    image=  "grafana/grafana:latest"
      
    #define ports
    ports {
    internal=3000
    external=3000
    }
    #mount volumes
    volumes {
        host_path="/var/lib/grafana"
        container_path="/var/lib/grafana"
    }
    #connect the container to the network
    networks_advanced{
        name="docker_network.grafana_network.name"
    }
    #container auto restart policy
    restart ="always"
}

##########data sources:
data "grafana_cloud_ips" "test" {}

##########variables:

##########outputs:
output "grafana_url" {
value = "http://localhost:3000"
}