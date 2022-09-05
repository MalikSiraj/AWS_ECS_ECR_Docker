resource "aws_lb" "test-lb" {
  name               = "test-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  #subnets            = var.alb_public_subnets
  subnets            = [for subnet in var.alb_public_subnets : subnet]
  tags = {
    "env"       = "dev"
    "createdBy" = "siraj"
  }
  security_groups = [var.security_group_lb.id]
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "nginx-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  #target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}