## How to use

1. git checkout git@github.com:wellsaar/terraform-js2.git
2. Edit ubuntu20.tfvars to set the name of your jetstream keypair
3. Run ``` terraform apply -var-file="ubuntu20.tfvars"``` and review the changes


### Instance 2

Ubuntu server with nginx + r/shiny server

1. setup ubuntu 20
2. make sure system is up to date
3. install nginx
4. install r and shiny
5. reverse proxy back to 443 {letsencrypt/acme}
6. limit firewall to 80,443,22 and 3838
