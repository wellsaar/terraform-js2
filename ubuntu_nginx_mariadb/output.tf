################
#Output
################


output "floating_ip_ubuntu20" {
  value       = openstack_networking_floatingip_v2.terraform_floatip_ubuntu22.address
  description = "Public IP for Ubuntu 22"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
      ubuntu20 = openstack_networking_floatingip_v2.terraform_floatip_ubuntu22.*.address,
    }
  )
  filename = "ansible/inventory.ini"
}

data "openstack_identity_auth_scope_v3" "self_lookup" {
  name = "self_lookup"
}

output "url" {
  value = "http://${openstack_compute_instance_v2.ubuntu22.name}.${data.openstack_identity_auth_scope_v3.self_lookup.project_name}.projects.jetstream-cloud.org"
}