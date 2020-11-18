resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg_app_1.arn
    type             = "forward"
  }
}

# /app1
resource "aws_lb_listener_rule" "app1_listener_rule" {
  listener_arn = aws_alb_listener.listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg_app_1.arn
  }

  condition {
    path_pattern {
      values = ["*app1*"]
    }
  }
}

# /app2
resource "aws_lb_listener_rule" "app2_listener_rule" {
  listener_arn = aws_alb_listener.listener.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg_app_2.arn
  }

  condition {
    path_pattern {
      values = ["*app2*"]
    }
  }
}

# /app3
resource "aws_lb_listener_rule" "app3_listener_rule" {
  listener_arn = aws_alb_listener.listener.arn
  priority     = 102

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg_app_3.arn
  }

  condition {
    path_pattern {
      values = ["*app3*"]
    }
  }
}