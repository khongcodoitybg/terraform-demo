resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.lb_name}-tg"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "ec2_attachments" {
  count            = length(var.ec2_attachments)
  target_group_arn = aws_lb_target_group.this.arn # ARN of target group
  target_id        = var.ec2_attachments[count.index]
  port             = var.target_port
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
