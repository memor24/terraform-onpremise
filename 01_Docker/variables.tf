
#container volume variables
variable "container_name" {
  default = "nginx_cntnr"
  type    = string
}
variable "container_path" {
  default = "/usr/share/nginx"
  type    = string
}

variable "container_network" {
  type= object{
    name= string
    driver= string
  }
  default={
    name= "my_network4nginx"
    driver="bridge"
  }
}
