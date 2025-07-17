resource "aws_lb" "public_alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = "public-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "backend-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "backend_attachment" { 
 target_group_arn = aws_lb_target_group.tg.arn
 target_id = var.backend_instance_ids[count.index] 
 port             = 80
 count = length(var.backend_instance_ids)
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

