################
#VMs
################
# creating leader

resource "openstack_networking_floatingip_v2" "terraform_floatip_ubuntu22" {
  pool = "public"
}

# assigning floating ip from public pool to ubuntu22 VM
resource "openstack_compute_floatingip_associate_v2" "ubuntu22_float" {
  floating_ip           = openstack_networking_floatingip_v2.terraform_floatip_ubuntu22.address
  instance_id           = openstack_compute_instance_v2.ubuntu22.id
  wait_until_associated = true
}

resource "openstack_compute_instance_v2" "ubuntu22" {
  name =" ${data.openstack_identity_auth_scope_v3.self_lookup.user_name}-nginx"
  # ID of JS-API-Featured-ubuntu22-Latest
  #image_id  = var.image_id
  image_name = "Featured-Ubuntu22"
  flavor_id  = var.flavor_id
  # you'll need to set this to your public key name on jetstream
  key_pair        = var.key_pair
  security_groups = ["${openstack_networking_secgroup_v2.ssh_ping_security_group.id}", "default", "${openstack_networking_secgroup_v2.http_https_security_group.id}"]
  metadata = {
    terraform_controlled = "yes"
    terraform_role       = "nginx_mariadb"
  }
  network {
    name = "auto_allocated_network"
  }
}

resource "null_resource" "ansible_provisioners" {
  provisioner "remote-exec" {
    inline = [
      "echo \"Checking if cloud init is running\"",
      "sudo cloud-init status --wait",
      "sudo apt update",
      "sudo apt install python3 ansible -y",
      "rm -rf ~/ansible"
    ]
    connection {
      type = "ssh"
      host = openstack_networking_floatingip_v2.terraform_floatip_ubuntu22.address
      user = "ubuntu"
    }
  }
  provisioner "file" {
    source      = "ansible"
    destination = "ansible"
  }
  connection {
    type = "ssh"
    host = openstack_networking_floatingip_v2.terraform_floatip_ubuntu22.address
    user = "ubuntu"
  }
  provisioner "remote-exec" {
    inline = [
      "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/inventory.ini ansible/main.yml ",
    ]
    connection {
      type = "ssh"
      host = openstack_networking_floatingip_v2.terraform_floatip_ubuntu22.address
      user = "ubuntu"
    }
  }

  depends_on = [openstack_compute_floatingip_associate_v2.ubuntu22_float]
}
