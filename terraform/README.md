How to prepare this for deployment
==================================
Either create `terraform.tfvars` or set the variables in your workspace if you
use Terraform Cloud.

Variables
---------
* `dns_domain` - this will be used to look up for a certificate for the HTTPS
  listener of the loadbalancer in AWS ACM. If you don't have a domain, you can't
  deploy HTTPS listener.
* `key_pair_file_name` - this is the SSH key pair file name. It will be used to
  SSH into the instances. By default it will search for  `id_ed25519.pub` in the
  current directory.
* `ipv4_ssh_allow` - this is the IPv4 CIDR block to allow SSH access from.
* `http_private_cidr_blocks` - this is a list of IPv4 CIDR blocks to allow HTTP
  access from - targeted between the load balancer and the instances. Use a
  private IP range here.