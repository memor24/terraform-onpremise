terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

#sample nginx image from dockerhub via api
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = "false"
}

#creates the nginx container using the created image
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "var.docker_container.name"
  ports {
    internal = 80
    external = 80
  }
}

#creating a docker network locally
resource "docker_network" "my-network" {

}