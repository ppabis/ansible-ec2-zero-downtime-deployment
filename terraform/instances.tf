resource "aws_key_pair" "app-key" {
  key_name   = "app-key"
  public_key = file("./id_ed25519.pub")
}

resource "aws_instance" "app" {
  count         = 2
  ami           = data.aws_ami.amzn2.id # Amazon Linux 2 for ARM
  instance_type = "t4g.nano"
  key_name      = "app-key"
  security_groups = [
    aws_security_group.http.id,
    aws_security_group.ssh.id
  ]
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["158.181.0.0/16"]
    ipv6_cidr_blocks = []
    security_groups  = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = []
  }
}

resource "aws_security_group" "http" {
  name        = "http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8", "172.28.0.0/16"]
  }
}