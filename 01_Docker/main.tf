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
  name  = "var.container_name"
  ports {
    internal = 80
    external = 80
  }
  restart{
    default="on-failure"
  }
  volumes{
    container_path=var.container_path
    host_path=var.host_path
    read_only=var.read_only
    volume_name=var.volume_name
  }
}

#creating a docker network locally
resource "docker_network" "private-network" {
  name="my-network"
  scope=var.scope
}