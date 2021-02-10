## Exercise 1

* Navigate to the git tag `pe1` which you can find [here](https://github.com/terraform-course/mastercourse/tree/pe1)
* Apply the terraform code

* Make sure the Grafana EC2 instance does *not* have a public IP
* Create an application load balancer (ALB)
* Point the ALB to the Grafana EC2 instance (hint: `aws_lb_target_group_attachment`)
* Confirm you can reach the EC2 instance via the load balancer (and only via the loadbalancer)
