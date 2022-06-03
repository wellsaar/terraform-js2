################
#Networking
################
#creating the virtual network
resource "openstack_networking_network_v2" "terraform_network_r_shiny" {
  name = "terraform_network_r_shiny"
  admin_state_up  = "true"
}

#creating the virtual subnet
resource "openstack_networking_subnet_v2" "terraform_subnet1_r_shiny" {
  name = "terraform_subnet1_r_shiny"
  network_id  = "${openstack_networking_network_v2.terraform_network_r_shiny.id}"
  cidr  = "192.168.0.0/24"
  ip_version  = 4
}
# setting up virtual router
resource "openstack_networking_router_v2" "terraform_router_r_shiny" {
  name = "terraform_router_r_shiny"
  admin_state_up  = true
  # id of public network on JS2
  external_network_id = "3fe22c05-6206-4db2-9a13-44f04b6796e6"
}
# setting up virtual router interface
resource "openstack_networking_router_interface_v2" "terraform_router_interface_1" {
  router_id = "${openstack_networking_router_v2.terraform_router_r_shiny.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform_subnet1_r_shiny.id}"
}
