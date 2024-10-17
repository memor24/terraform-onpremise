#creates a (sample nginx) image from dockerhub
# equivalent cmd: 'docker pull nginx:latest'
resource "docker_image" "nginx_image" {
  name         = "nginx/nginx:latest"
  keep_locally = "false"
}

#creates the nginx container using the created image
resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = "docker_image.nginx_image.image_id"
  ports {
    internal = 80
    external = 8080 #nginx service on the docker network
  }
  #mounting a volume for persistent data
  volumes {
    container_path = var.container_path
  }
  #connecting the container to the docker network
  networks_advanced {
    name = docker_network.private_network.name
  }
  #container auto restart
  restart = "always"
}

#creating a docker network for nginx containers
resource "docker_network" "private_network" {
  name   = var.container_network.name
  driver = var.container_network.driver
}

###outputs:
output "nginx_url" {
  value = "http://localhost:8080"
}

output "container_ip" {
  value = "docker_container.nginx_container.network_data[0].ip_address"
}
