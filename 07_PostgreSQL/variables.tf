variable "username" {
  default = "postgres"
  type    = string
}

variable "password" {
  default   = "postgres"
  type      = string
  sensitive = true
}