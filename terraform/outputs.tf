output "ami-name" {
  value = data.aws_ami.amzn2.name
}

output "ami-descr" {
  value = data.aws_ami.amzn2.description
}

output "ips" {
  value = aws_instance.app.*.public_ip
}

output "target_group_arn" {
  value = aws_alb_target_group.apps.arn
}