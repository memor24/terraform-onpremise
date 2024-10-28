resource kaproxy_global "global" {
    user="haproxy"
    group="haproxy"
    chroot="/var/lib/haproxy"
    daemon=true 
    master_worker=true 
    maxconn=2000
    stats_maxconn=100
    stats_timeout=60
    crt_base= "/etc/ssl/certs"
    crt_ca="/etc/ssl/private"
    ssl_default_bind_ciphers = "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256"
    ssl_default_bind_options = "no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
}

resource haproxy_defaults "new_defaults" {
    name="test"
    mode="http"
    httplog= true
    httpslog= truetcplog= false
    client_timeout          = 10
    connect_timeout         = 10
    http_keep_alive_timeout = 10
    http_request_timeout    = 10
    queue_timeout           = 10
    server_timeout          = 9
    server_fin_timeout      = 10
    maxconn                 = 2000
}

resource haproxy_backend "new_backend" {
    name="new_backend"
    mode="http"
    http_connection_mode = "http-keep-alive"
    server_timeout       = 9
    check_timeout        = 20
    connect_timeout      = 20
    queue_timeout        = 20
    tarpit_timeout       = 20
    tunnel_timeout       = 20
    check_cache          = true

    balance {
        algorithm="roundrobin"
    }

    httpchk_params {
        uri     = "/health"
        version = "HTTP/1.1"
        method  = "GET"
  }

  forwardfor {
        enabled = true
  }
}


resource haproxy_acl "new_acl" {
    name        = "new_acl"
    index       = 0
    parent_name = "new_backend"
    parent_type = "backend"
    value       = "example.com"
    depends_on = [haproxy_backend.new_backend]
}

resource haproxy_server "new_server" {
    name        = "new_server"
    port        = 8080
    #address     = "172.16.13.15"
    parent_name = "new_backend"
    parent_type = "backend"
    send_proxy  = true
    check       = true
    inter       = 2
    rise        = 3
    fall        = 3
    depends_on = [haproxy_backend.new_backend]
}



resource haproxy_frontend "new_frontend" {
    name="new_frontend"
    backend="new_backend"

    compression {
    algorithms = ["gzip", "identity"]
    offload    = true
    types      = ["text/html", "text/plain", "text/css", "application/javascript"]
  }

    forwardfor {
    enabled = true
    header  = "X-Forwarded-For"
    ifnone  = true
  }

    depends_on = [haproxy_backend.new_backend]
}

resource haproxy_bind "new_bind" {
    name="new_bind"
    port="8080"
    address="0.0.0.0"
    parent_name= "new_frontend"
    parent_type= "new_backend"
    maxconn=3000
    depends_on = [haproxy_frontend.new_frontend]
}