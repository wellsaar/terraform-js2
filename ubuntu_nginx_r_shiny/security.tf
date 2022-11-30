################
#Security section
################
#creating security group

resource "openstack_networking_secgroup_v2" "ssh_ping_security_group" {
  name        = "SSH and ICMP Ingress"
  description = "This allows ssh and ICMP packets into the instance"
}

resource "openstack_networking_secgroup_rule_v2" "ssh_security_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.ssh_ping_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "ICMP_security_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.ssh_ping_security_group.id
}

resource "openstack_networking_secgroup_v2" "http_https_security_group" {
  name        = "HTTP/HTTPS Ingress"
  description = "This allows http (80) and https (443) traffic into the instance."
}

resource "openstack_networking_secgroup_rule_v2" "http_security_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.http_https_security_group.id
}
resource "openstack_networking_secgroup_rule_v2" "https_security_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.http_https_security_group.id
}