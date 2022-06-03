################
#VMs
################
# creating leader

resource "openstack_networking_floatingip_v2" "terraform_floatip_ubuntu20" {
  pool = "public"
}

# assigning floating ip from public pool to Ubuntu20 VM
resource "openstack_compute_floatingip_associate_v2" "Ubuntu20_float" {
  floating_ip = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.address}"
  instance_id = "${openstack_compute_instance_v2.Ubuntu20.id}"
  wait_until_associated = true
}

resource "openstack_compute_instance_v2" "Ubuntu20" {
  name = "terraform_Ubuntu20_nginx"
  # ID of JS-API-Featured-Ubuntu20-Latest
  #image_id  = var.image_id
  image_name = "Featured-Ubuntu20"
  flavor_id = var.flavor_id
  # you'll need to set this to your public key name on jetstream
  key_pair  = var.key_pair
  security_groups   = ["terraform_ssh_ping_http_https", "default"]
  metadata = {
    terraform_controlled = "yes"
  }
  network {
    name = "terraform_network"
  }

  depends_on = [openstack_networking_network_v2.terraform_network]
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
        host = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.address}"
        user = "ubuntu"
      }
  }
  provisioner "file" {
    source = "ansible"
    destination = "ansible"
  }
      connection {
        type = "ssh"
        host = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.address}"
        user = "ubuntu"
      }
  provisioner "remote-exec" {
    inline = [
      "ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/inventory.ini ansible/main.yml ",
    ]
      connection {
        type = "ssh"
        host = "${openstack_networking_floatingip_v2.terraform_floatip_ubuntu20.address}"
        user = "ubuntu"
      }
    }

  depends_on = [openstack_compute_floatingip_associate_v2.Ubuntu20_float]
}
