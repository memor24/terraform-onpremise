# vmware esxi vsphere + vcenter(server) and connections
terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.11.1"
    }
  }
}

# vsphere provider 
# vsphere data
# vsphere resources


# prep ansible 
resource local_file "vm_ip" {
  content= vsphere_virtual_machine.standalone.default_ip_address
  filename= vm_ip.txt
}

resource null_resource "remote" {
  depends_on= [vsphere_virtual_machine.standalone]
  connection{
    type= "ssh"
    user= "root"
    password= var.password
    host= var.host
  }
}
provisioner "file" {
  source= "vm_ip.txt"
  dest= "hosts.txt" # the inventory file
}

# run ansible locally
provisioner "local-exec" {
 inline=[
   "ansible-playbook install_grafana.yml"
 ]
}

output "my_ip_address" {
  value= vsphere_virtual_machine.standalone.default_ip_address
}