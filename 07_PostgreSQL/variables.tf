variable "port" {
  type    = number
  default = 5432
}

variable "host" {
  default     = "localhost"
  description = "host address" #e.g. "postgres_server_ip"
}

variable "username" {
  default = "postgres_user"
  type    = string
}

variable "password" {
  default = "admin"
  type    = string
}