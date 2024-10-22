In order to access the output URL remotely, the docker daemon need to be configured prior to applying Terraform.

 Map host = "unix:///var/run/docker.sock" to tcp://localhost:2376 in the docker daemon 
