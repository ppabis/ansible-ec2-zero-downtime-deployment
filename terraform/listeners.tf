/* resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  certificate_arn   = data.aws_acm_certificate.dns-cert.arn
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not found!"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "apps" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.apps.arn
  }

  condition {
    path_pattern {
      values = ["/apps/*", "/apps"]
    }
  }
} */