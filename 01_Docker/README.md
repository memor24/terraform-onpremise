# Docker
This will create Docker resources to run a container on a local network.

## Local Docker Setup

To use Terraform with Docker on your local machine, the Docker provider needs to be configured to access the local Docker daemon using the Unix socket.

### Provider Configuration (Local)
```
provider "docker" {  
  host = "unix:///var/run/docker.sock"   #docker daemon for local access by terraform
}
```

For preparation:
```
terraform fmt
terraform init
terraform validate
terraform plan
```
For creation and removal:
```
terraform apply
terraform destroy
```
