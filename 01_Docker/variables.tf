
#container volume variables
variable "container_name" {
  default = "nginx_cntnr"
  type    = string
}
variable "container_path" {
  default = "/usr/share/nginx/html"
  type    = string
}

variable "volume_name" {
  default = "nginx_vlm"
  type    = string
}
