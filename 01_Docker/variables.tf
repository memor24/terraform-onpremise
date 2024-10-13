
#container volume variables
variable  container_name{
  default     = "sth"
  type        = string
}
variable container_path{
  default="/usr/share/nginx/html"
  type= string
}
variable host_path{
  default="/data"
  type= string
}
variable read_only{
  default=false
  type= bool
}
variable volume_name{
  default= "sth_volume"
  type=string
}

#container network variables
variable scope{
  type= string
  default="local" #either swarm/global/local
}