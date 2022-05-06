################
#Output
################


output "floating_ip_ubuntu20" {
  value = openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.address
  description = "Public IP for Ubuntu 20"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl",
  {
    ubuntu20    = openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.*.address,
  }
  )
  filename  = "ansible/inventory.ini"
}

resource "local_file" "email" {
  content = var.email
  filename  = "ansible/email.txt"
}
