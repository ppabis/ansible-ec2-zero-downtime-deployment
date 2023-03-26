data "aws_subnets" "subnets" {
    filter {
      name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

resource "aws_lb" "loadbalancer" {
    name               = "loadbalancer"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.loadbalancer.id]
    subnets            = data.aws_subnets.subnets.ids
    
    tags = {
        Name = "loadbalancer"
    }
}

resource "aws_security_group" "loadbalancer" {
    name = "Loadbalancer-SG"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups = []
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups = []
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups = []
    }
}
