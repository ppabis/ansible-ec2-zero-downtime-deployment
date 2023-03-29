variable "dns_domain" {
  type        = string
  description = "DNS domain for the SSL certificate for the LB"
}

variable "key_pair_file_name" {
    type        = string
    description = "Name of the SSH key pair file"
    default = "./id_ed25519.pub"
}

variable "ipv4_ssh_allow" {
    type        = string
    description = "IPv4 CIDR block to allow SSH access from"
    default = "0.0.0.0/0"
}

variable "http_private_cidr_blocks" {
    type = list(string)
    description = "List of IPv4 CIDR blocks to allow HTTP to the instances"
    default = [ "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16" ]
  
}