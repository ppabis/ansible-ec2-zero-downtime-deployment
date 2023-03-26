data "aws_ami" "amzn2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "architecture"
    values = ["arm64"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

output "ami-name" {
  value = data.aws_ami.amzn2.name 
}

output "ami-descr" {
  value = data.aws_ami.amzn2.description
}

resource "aws_instance" "app" {
  count = 2
  ami = data.aws_ami.amzn2.id   # Amazon Linux 2 for ARM
  instance_type = "t4g.nano"
  key_name = "app-key"
}