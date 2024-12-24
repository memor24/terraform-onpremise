
variable "container_name" {
  default = "alpine_cntnr"
  type    = string
}
variable "container_path" {
  default = "/usr/share/alpine/html"
  type    = string
}

variable "container_network" {
  type = object({
    name   = string
    driver = string
  })
  default = {
    name   = "my_network4alpine"
    driver = "bridge"
  }
}
