data "aws_ami" "amzn2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-aarch64-ebs"]
  }
}

resource "aws_instance" "app" {
  count = 2
  ami = data.aws_ami.amzn2.id   # Amazon Linux 2 for ARM
  instance_type = "t4g.nano"
  key_name = "app-key"
}