#######################################
# Create ALB with Security Group
#######################################

# Security Group For ALB
resource "aws_security_group" "allow_https" {
  name        = "ALB Security Group"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS Traffic on ALB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "Allow HTTPS Traffic on ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_https_alb"
    Environment = var.env
  }
}

# ALB
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.is_internal
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.allow_https.id]
  subnets            = var.alb_subnet_ids

  enable_deletion_protection = var.alb_enable_deletion_protection

  access_logs {
    bucket  = var.alb_logging_bucket
    prefix  = "${var.alb_name}/logging"
    enabled = true
  }

  tags = {
    Name = var.alb_name
    Environment = var.env
  }
}

