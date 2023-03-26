output "ami-name" {
  value = data.aws_ami.amzn2.name
}

output "ami-descr" {
  value = data.aws_ami.amzn2.description
}

/* output "ips" {
  value = aws_instance.app.*.public_ip
} */