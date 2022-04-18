################
#VMs
################
# creating leader

resource "openstack_compute_instance_v2" "Ubuntu20" {
  name = "terraform_Ubuntu20"
  # ID of JS-API-Featured-Ubuntu20-Latest
  image_id  = "8f27559a-9e63-4fb7-9704-09526793e2d2"
  flavor_id   = 3
  # you'll need to set this to your public key name on jetstream
  key_pair  = "wellsaar"
  security_groups   = ["terraform_ssh_ping", "default"]
  metadata = {
    terraform_controlled = "yes"
  }
  network {
    name = "terraform_network"
  }
  depends_on = [openstack_networking_network_v2.terraform_network]

}

resource "openstack_networking_floatingip_v2" "terraform_floatip_ubuntu20" {
  pool = "public"
}

# assigning floating ip from public pool to Ubuntu20 VM
resource "openstack_compute_floatingip_associate_v2" "Ubuntu20_float" {
  floating_ip = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.address}"
  instance_id = "${openstack_compute_instance_v2.Ubuntu20.id}"
}
