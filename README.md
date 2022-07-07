# terraform-js2

This git repo will have multiple examples of using terraform for various
jetstream related instances.

## How to use

1. git checkout git@github.com:wellsaar/terraform-js2.git
2. Review ubuntu20.tfvars to set the name of your jetstream keypair and email address as well as domain name if needed.
3. Run ``` terraform apply -var-file="ubuntu20.tfvars"``` and review the changes

### Instance 1

Ubuntu server with Nginx and mongo/maria db installed.
1. setup ubuntu 20
2. make sure system is up to date
3. install nginx
4. install mongo,maria {bound to localhost}, and setup ufw firewall
6. limit firewall to 80,443,22

### Instance 2

Ubuntu server with nginx + r/shiny server

1. setup ubuntu 20
2. make sure system is up to date
3. install nginx
4. install r and shiny
5. reverse proxy back to 443 {letsencrypt/acme}
6. limit firewall to 80,443,22 and 3838
