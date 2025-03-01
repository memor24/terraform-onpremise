
resource "virtualbox_vm" "new_vboxvm" {
  name      = "LinuxGrafana"
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = var.cpu
  memory    = var.ram
  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }
}

output "vm_ip" {
  value = element(virtualbox_vm.newvbox_vm.*.network_adapter.0.ipv4_address, 1)
}

# prep to run the ansible
resource "local_file" "vm_ip" {
  content   = element(virtualbox_vm.newvbox_vm.*.network_adapter.0.ipv4_address, 1)
  file_name = vm_ip.txt

  provisioner "file" {
    source      = "vm_ip"
    destination = "hosts.txt" # on the vm, connected as root
  }
}

resource "null_resource" "sshconnection" {
  depends_on = [virtualbox_vm.new_vboxvm]
  connection {
    type     = "ssh"
    user     = "root"
    password = var.password # defined in tfvars
    host     = var.host
  }

  # run the ansible to install and run the monitoring stack
  provisioner "local-exec" {
    inline = [
      "ansible-playbook install_grafana.yml"
    ]

  }
}



