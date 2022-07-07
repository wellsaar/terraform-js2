################
#Security section
################
#creating security group
resource "openstack_compute_secgroup_v2" "terraform_ssh_ping_http_https_r_shiny" {
  name = "terraform_ssh_ping_http_https_r_shiny"
  description = "Security group with SSH,PING,HTTP/HTTPS open to 0.0.0.0/0"

  #ssh rule
  rule{
    ip_protocol = "tcp"
    from_port  =  "22"
    to_port    =  "22"
    cidr       = "0.0.0.0/0"
  }
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
  rule{
    ip_protocol = "tcp"
    from_port  =  "80"
    to_port    =  "80"
    cidr       = "0.0.0.0/0"
  }
  rule{
    ip_protocol = "tcp"
    from_port  =  "443"
    to_port    =  "443"
    cidr       = "0.0.0.0/0"
  }
}
