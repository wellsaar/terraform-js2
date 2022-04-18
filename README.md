# terraform-js2

This git repo will have multiple examples of using terraform for various
jetstream related instances.

### Instance 1

Ubuntu server with Nginx and mongo/maria db installed.
1. setup ubuntu 20
2. make sure system is up to date
3. install nginx
4. install mongo,maria {bind to localhost}, and setup ufw firewall
6. limit firewall to 80,443,22

### Instance 2

Ubuntu server with nginx + r/shiny server

1. setup ubuntu 20
2. make sure system is up to date
3. install nginx
4. install r and shiny
5. reverse proxy back to 443 {letsencrypt/acme}
6. limit firewall to 80,443,22 and 3838
