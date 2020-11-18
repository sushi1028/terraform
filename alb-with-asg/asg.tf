###############################################
# Autoscaling Configurations
################################################

#################### APP1 ######################### 
# Security Group
resource "aws_security_group" "app1_sg" {
  name        = "APP1 Security Group"
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
    Name = "app1_sg"
    Environment = var.env
  }
}

resource "aws_launch_configuration" "app1_launch_config" {
  name                 = "${var.app_name_1}-launchconfig"
  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.instance_key
  security_groups      = [aws_security_group.app1_sg.id]
  user_data            = file("${path.module}/scripts/app1_userdata.sh")
}

resource "aws_autoscaling_group" "app1_autoscaling_group" {
  name                      = "${var.app_name_1}-ASG"
  depends_on                = [aws_launch_configuration.app1_launch_config]
  vpc_zone_identifier       = var.autoscaling_subnets
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.app1_launch_config.id
}

resource "aws_autoscaling_attachment" "app1_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app1_autoscaling_group.id
  alb_target_group_arn   = aws_alb_target_group.tg_app_1.arn
}

################### APP2 ################################
# Security Group
resource "aws_security_group" "app2_sg" {
  name        = "APP2 Security Group"
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
    Name = "app2_sg"
    Environment = var.env
  }
}

resource "aws_launch_configuration" "app2_launch_config" {
  name                 = "${var.app_name_2}-launchconfig"
  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.instance_key
  security_groups      = [aws_security_group.app2_sg.id]
  user_data            = file("${path.module}/scripts/app2_userdata.sh")
}

resource "aws_autoscaling_group" "app2_autoscaling_group" {
  name                      = "${var.app_name_2}-ASG"
  depends_on                = [aws_launch_configuration.app2_launch_config]
  vpc_zone_identifier       = var.autoscaling_subnets
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.app2_launch_config.id
}

resource "aws_autoscaling_attachment" "app2_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app2_autoscaling_group.id
  alb_target_group_arn   = aws_alb_target_group.tg_app_2.arn
}

################# APP3 ########################
# Security Group
resource "aws_security_group" "app3_sg" {
  name        = "APP3 Security Group"
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
    Name = "app3_sg"
    Environment = var.env
  }
}

resource "aws_launch_configuration" "app3_launch_config" {
  name                 = "${var.app_name_3}-launchconfig"
  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.instance_key
  security_groups      = [aws_security_group.app3_sg.id]
  user_data            = file("${path.module}/scripts/app3_userdata.sh")
}

resource "aws_autoscaling_group" "app3_autoscaling_group" {
  name                      = "${var.app_name_3}-ASG"
  depends_on                = [aws_launch_configuration.app3_launch_config]
  vpc_zone_identifier       = var.autoscaling_subnets
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.app3_launch_config.id
}

resource "aws_autoscaling_attachment" "app3_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app3_autoscaling_group.id
  alb_target_group_arn   = aws_alb_target_group.tg_app_3.arn
}
########################################################################

