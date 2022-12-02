################
#Output
################


output "floating_ip_ubuntu22" {
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

resource "local_file" "email" {
  content  = var.email
  filename = "ansible/email.txt"
}

resource "local_file" "domain_name" {
  content  = "${openstack_compute_instance_v2.Ubuntu22.name}.${data.openstack_identity_auth_scope_v3.self_lookup.project_name}.projects.jetstream-cloud.org"
  filename = "ansible/domain_name.txt"
}

output "url" {
  value = "https://${openstack_compute_instance_v2.Ubuntu22.name}.${data.openstack_identity_auth_scope_v3.self_lookup.project_name}.projects.jetstream-cloud.org"
}