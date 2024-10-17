#creates a sample nginx image from dockerhub via api
resource "docker_image" "nginx_image" {
  name         = "nginx/nginx:latest"
  keep_locally = "true"
}

#creating a volume that will be mounted on the container
resource "docker_volume" "container_data" {
  name = var.volume_name
}

#creates the nginx container using the created image
resource "docker_container" "nginx_container" {
  name  = "var.container_name"
  image = "docker_image.nginx_image.name"
  ports {
    internal = 80
    external = 8080 #nginx service on the docker network
  }
  volumes { #mounting a volume on to the container
    container_path = var.container_path
    volume_name    = var.volume_name
  }
  networks_advanced { #connecting the container to the docker network
    name = docker_network.private_network.name
  }

  restart = "always" #container auto restart
}

#creating a docker network
resource "docker_network" "private_network" {
  name = "my-network"
}


output "nginx_url" {
  value = "http://localhost:8080"
}

output "container_ip" {
  value = "docker_container.nginx.network_data[0].ip_address"
}
