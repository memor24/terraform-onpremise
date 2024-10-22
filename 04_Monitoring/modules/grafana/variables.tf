variable "grafana_port" {
  type        = number
  default     = 3000
  description = "grafana port exposed as UI"
}

variable "network_name" {
  type        = string
  description = "docker network's name"
}
