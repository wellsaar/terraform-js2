variable "flavor_id" {
  default     = "3"
  description = "Flavor of VM on Jetstream 2"
}

variable "key_pair" {
  default = ""
}

variable "email" {
  default = ""
}

variable "domain_name" {
  default = "${openstack_compute_instance_v2.Ubuntu22.name}.${data.openstack_identity_auth_scope_v3.self_lookup.project_name}.projects.jetstream-cloud.org"
}

