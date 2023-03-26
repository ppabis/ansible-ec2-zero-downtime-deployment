resource "aws_alb_target_group" "apps" {
  name = "apps"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id
  target_type = "instance"
  
  health_check {
    path = "/"
    port = "80"
    protocol = "HTTP"
    interval = 30
    timeout = 20
  }
  
}