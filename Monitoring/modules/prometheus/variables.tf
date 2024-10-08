variable prometheus_port {
  type        = number
  default     = 9091
  description = "prometheus port exposed to stream metrics"
}

variable network_name {
  type        = string
  description = "docker network's name"
}
