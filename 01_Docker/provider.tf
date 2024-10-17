terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "> 3.0" #">= 2.16.0"
    }
  }
}

 provider "docker" {
  host = "unix:///var/run/docker.sock" #to run docker daemon for local access by terraform
   #or tcp://localhost:2376 #plus config: to access remotely also
 }