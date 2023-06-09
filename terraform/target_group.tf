resource "aws_alb_target_group" "apps" {
  name        = "apps"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "instance"
  deregistration_delay = 15

  health_check {
    path     = "/healthcheck"
    port     = 8080
    protocol = "HTTP"
    interval = 12
    timeout  = 10
    healthy_threshold = 2
    unhealthy_threshold = 2
    matcher = "200-210"
  }

}