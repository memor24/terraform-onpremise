# VMware ESXi (hosting an ubuntu)

# vsphere datasource

data "vsphere_datacenter" "dc"{
  name="dc-01"
}

data "vsphere_datastore" "ds"{
  name="datastore-01"
  datacenter_id=data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cc"{
  name="cluster-01"
  datacenter_id=data.vsphere_datacenter.dc.id 
}

data "vsphere_network" "nw"{
  name="VM Network"
  datacenter_id=data.vsphere_datacenter.dc.id
}

# vsphere resources

resource "vsphere_virtual_machine" "vm" {
  name=
  resource_pool_id=data.vsphere_compute_cluster.cc.resource_pool_id
  datastore_id=data.vsphere_datastore.ds.id
  num_cpus=var.num_cpu
  memory=var.ram
  guest_id="zabbix_server_agent2"
  network_interface{
    network_id=data.vsphere_network.nw.id
  }
  disk{
    label="disk0"
    size=20
  }
}
## output
output "my_ip_address" {
  value= vsphere_virtual_machine.vm.default_ip_address
}

### prep for ansible 
resource local_file "vm_ip" {
  content= vsphere_virtual_machine.vm.default_ip_address
  filename= vm_ip.txt # vm ip created as a local file
}

resource null_resource "remote" {
  depends_on= [vsphere_virtual_machine.vm]
  connection{
    type= "ssh"
    user= "root"
    password= var.password # in tfvars or as secret
    host= var.host # in tfvars
  }
}

provisioner "file" {
  source= "vm_ip.txt"
  dest= "hosts.txt" # the inventory file
}

# run ansible on the vm
provisioner "local-exec" {
 inline=[
   command = "ansible-playbook -i /root/hosts.txt ./zabbix/playbook.yml"
 ]
}