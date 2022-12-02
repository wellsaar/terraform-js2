## How to use

1. git checkout git@github.com:wellsaar/terraform-js2.git
2. Edit Ubuntu22.auto.tfvars to set the name of your jetstream keypair as well as your email address.
3. Run ``` terraform apply``` and review the changes
4. Once the ansible job has finished, it will output the domain name for your shiny server. https://shiny.(Jetstream Allocation Name here).projects.jetstream-cloud.org

### Instance 2

Ubuntu server with nginx + r/shiny server

1. setup ubuntu 22
2. make sure system is up to date
3. install nginx
4. install r and shiny
5. reverse proxy back to 443 {letsencrypt/acme}
6. limit firewall to 80,443,22 and 3838