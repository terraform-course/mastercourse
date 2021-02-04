## Exercise 2
### (Extra Credit) 

* Create a digitalocean droplet and a digitalocean loadbalancer that forwards traffic to that droplet. 
* Add your ssh key to the droplet. 
* All other options are up to you. 
* Create two outputs: one for the loadbalancer ip, one for the droplet ip.
* Once the droplet is up, grab its ip from the output and ssh to it and install a webserver of your choice, e.g. nginx.
* Make sure it's serving traffic on the port that you configured on your loadbalancer, by hitting the loadbalancer ip on your browser.

After you've done all this successfully, run `terraform destroy` to destroy the infrastructure.