# 1. createing image (a sample nginx from dockerhub):
#need to define the image seperately to be managed by terraform
# equivalent cmd: 'docker pull nginx:latest'
# this is how images are created in kreuzwerker/docker
data "docker_registry_image" "sth_image" {
  name = "nginx:latest"
}
resource "docker_image" "sample_image" {
  name          = data.docker_registry_image.sth_image.name
  pull_triggers = [data.docker_registry_image.sth_image.sha256_digest]
}

# 2. creating a docker network for nginx containers
resource "docker_network" "private_network" {
  name   = var.container_network.name
  driver = var.container_network.driver
}

# 3. creates the nginx container using the created image
resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = docker_image.sample_image.name
  #ports binding
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

### 4. outputs:
output "nginx_url" {
  value = "http://localhost:8080"
}

output "container_ip" {
  value = docker_container.nginx_container.network_data[0].ip_address
}
