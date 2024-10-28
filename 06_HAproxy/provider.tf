terraform {
  required_version = ">= 0.15"
  required_providers {
    haproxy = {
      source  = "SepehrImanian/haproxy"
      version = "0.0.7"
    }
  }
}

provider "haproxy" {
  url      = "http://haproxy.example.com:8080"
  username = "user"
  password = "pass"
}