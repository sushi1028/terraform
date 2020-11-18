##################################################
# Create Three Target Groups (One per application)
#################################################
resource "aws_alb_target_group" "tg_app_1" {  
  name     = "${var.app_name_1}-tg"  
  port     = var.tg_port  
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    healthy_threshold   = var.healthy_threshold  
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout            
    interval            = var.health_check_interval           
    matcher             = var.health_check_matcher              # has to be HTTP 200
  }

  tags = {    
    Name = "${var.app_name_1}-tg"  
    Environment = var.env  
  }   
}

resource "aws_alb_target_group" "tg_app_2" {  
  name     = "${var.app_name_2}-tg"  
  port     = var.tg_port  
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    healthy_threshold   = var.healthy_threshold  
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout            
    interval            = var.health_check_interval           
    matcher             = var.health_check_matcher              # has to be HTTP 200
  }

  tags = {    
    Name = "${var.app_name_2}-tg"  
    Environment = var.env  
  } 

}

resource "aws_alb_target_group" "tg_app_3" {  
  name     = "${var.app_name_3}-tg"  
  port     = var.tg_port  
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    healthy_threshold   = var.healthy_threshold  
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout            
    interval            = var.health_check_interval           
    matcher             = var.health_check_matcher              # has to be HTTP 200
  }

  tags = {    
    Name = "${var.app_name_3}-tg"  
    Environment = var.env  
  }   
} 
  
