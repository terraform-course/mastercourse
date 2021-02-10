## Exercise 1

* Create a new folder and navigate to it. 
* Create a `main.tf` file. In that file, write terraform code that creates a Digitalocean droplet in a region of your choice. 
* The droplet size should be a variable with default value of `s-1vcpu-1gb`. 
* The image should be hardcoded to `ubuntu-18-04-x64`. 
* The name should be a variable as well. 
* Define the name in a `terraform.tfvars` file. 

After you've created the droplet as described successfully, run `terraform destroy` to destroy the infrastructure.