resource "aws_lb" "internal_alb" {
  name               = "int-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = var.private_subnet_ids
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = "int-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "internal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "internal-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "backend_attachment" {
  count            = length(var.backend_instance_ids)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.backend_instance_ids[count.index]
  port             = 80
}

