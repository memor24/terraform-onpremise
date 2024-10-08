variable grafana_port {
  type        = number
  default     = 3001
  description = "grafana port exposed as UI"
}

variable network_name {
  type        = string
  description = "docker network's name"
}
