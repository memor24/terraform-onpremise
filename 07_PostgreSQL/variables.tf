variable "username" {
  default   = "postgres_user"
  type      = string
  sensitive = true
}

variable "password" {
  default   = "admin"
  type      = string
  sensitive = true
}

variable "host" {
  default     = "localhost"
  description = "host address" #i.e. "postgres_server_ip"
}

variable "port" {
  type    = number
  default = 5432
}