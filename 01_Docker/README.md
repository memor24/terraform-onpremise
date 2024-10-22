# Provision of Docker with Terraform

This will create Docker resources to run a container on a local network.

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
### Provider Configuration (Remote)

```
provider "docker" {  
  host = "http://localhost:2376"   #docker daemon for remote access by terraform
}
```
To run Docker daemon for remote access by Terraform, the docker daemon need to be configured prior to applying Terraform:
```
sudo nano /etc/docker/daemon.json
```
and add this to daemon.json:
```
  {
   "hosts": ["http://localhost:2376"]
  }
```
 to check the integrity of the JSON file, run:
```
 cat /etc/docker/daemon.json | jq .
```
Then restart the docker service to make changes effective:
```
 sudo systemctl restart docker
 ```
 And if needed, update permissions:
```
 sudo usermod -aG docker $USER
 newgrp docker
 docker ps
 ```
The above steps can also be automated with a bash script using "null_resource" resource and "local_exec" provisioner:
```
resource null_resource name {

  provisioner "local-exec" {
    command = "bash script"
  }
}
```
Then, create all of the resources with Terraform:

For preparation:
```
terraform fmt
terraform init
terraform validate
terraform plan
```
For creation or removal:
```
terraform apply
terraform destroy
```
