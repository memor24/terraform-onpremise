## Monitoring containers
### Prometheus
Prometheus is a time-series database and a great tool for monitoring containers and cloud native infrastructure. It can collect, store and query (PromQL) time-series data, besides alerting, service discovery, etc.

A configured monitoring stack of modular prometheus & grafana is written as an onpremise local server. Could be scaled with Kubernetes.

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
