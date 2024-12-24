## Monitoring containers
### Prometheus
A configured monitoring stack of modular prometheus & grafana is written for onpremise infrastructure use. To be scaled with Docker Swarm or Kubernetes.

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
