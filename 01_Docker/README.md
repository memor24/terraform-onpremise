# Provision of Docker with Terraform

This will create Docker resources to run a container on a local network. It has also been tried and tested!

## Local Docker Setup

If you want to use Terraform with Docker on your local machine, the Docker provider needs to be configured to access the local Docker daemon using the Unix socket.

### Provider Configuration (Local)
```
provider "docker" {  
  host = "unix:///var/run/docker.sock"   #docker daemon for local access by terraform
}
```

Create all of the resources with Terraform:
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
