##################### EC2 WEB INSTANCE ###################################
resource "aws_instance" "web_1_instance" {
    ami                         = "${var.web_ami}"
    instance_type               = "${var.web_instance_type}"
    subnet_id                   = "${var.web_subnet_1_id}"
    key_name                    = "${var.web_key_name}"
    vpc_security_group_ids      = ["${var.web_sg_id}"]
    associate_public_ip_address = true
    user_data                   = "${file("${var.userdata}")}"
    tags = {
        Name = "web instance"
    }

}

resource "aws_instance" "web_2_instance" {
    ami                         = "${var.web_ami}"
    instance_type               = "${var.web_instance_type}"
    subnet_id                   = "${var.web_subnet_2_id}"
    key_name                    = "${var.web_key_name}"
    vpc_security_group_ids      = ["${var.web_sg_id}"]
    associate_public_ip_address = true
    user_data                   = "${file("${var.userdata}")}"
    tags = {
        Name = "web instance"
    }

}

################### EC2 APP INSTANCE ###################################

resource "aws_instance" "app_1_instance" {
    ami             = "${var.app_ami}"
    instance_type   = "${var.app_instance_type}"
    subnet_id       = "${var.app_subnet_1_id}"
    key_name        = "${var.web_key_name}"
    security_groups = ["${var.app_sg_id}"]

    tags = {
        Name = "app instance"
    }

}

resource "aws_instance" "app_2_instance" {
    ami             = "${var.app_ami}"
    instance_type   = "${var.app_instance_type}"
    subnet_id       = "${var.app_subnet_2_id}"
    key_name        = "${var.web_key_name}"
    security_groups = ["${var.app_sg_id}"]
    
    tags = {
        Name = "app instance"
    }

}

################### RDS INSTANCE #######################################

resource "aws_db_instance" "db_instance" {
    allocated_storage    = "${var.rds_storage}"
    engine               = "${var.rds_engine}"
    instance_class       = "${var.rds_instance_class}"
    name                 = "${var.rds_name}"
    username             = "${var.rds_username}"
    password             = "${var.rds_password}"
    db_subnet_group_name = "${var.rds_subnet_group_name}"
    skip_final_snapshot  = true
}

################# LOAD BALANCER ###########################################
# lb
resource "aws_alb" "web_alb" {
    # name            = "web alb"
    internal        = "false"
    security_groups = ["${var.lb_sg_id}"]
    subnets         = ["${var.web_subnet_1_id}", "${var.web_subnet_2_id}"]

    tags = {
        Name = "web server lb"
    }
}

################# LOAD BALANCER TARGET GROUP ###############################

resource "aws_alb_target_group" "web_alb_tg" {
    # name    = "web alb tg"
    port    = 80
    protocol= "HTTP"
    vpc_id  = "${var.vpc_id}"
}

# listener
resource "aws_alb_listener" "alb_http_listener" {
  load_balancer_arn = "${aws_alb.web_alb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.web_alb_tg.arn}"
    type = "forward"
  }
}
################# LOAD BALANCER TARGET GROUP ATTACH ######################################

resource "aws_alb_target_group_attachment" "web_1_alb_attach" {
    target_group_arn    = "${aws_alb_target_group.web_alb_tg.arn}"
    target_id           = "${aws_instance.web_1_instance.id}"
    port                = 80
}

resource "aws_alb_target_group_attachment" "web_2_alb_attach" {
    target_group_arn    = "${aws_alb_target_group.web_alb_tg.arn}"
    target_id           = "${aws_instance.web_2_instance.id}"
    port                = 80
}

################# AUTOSCALING LAUNCH CONFIGURATION #####################################

resource "aws_launch_configuration" "web_server_launch_config" {
    name                    = "web_server_lc"
    image_id                = "${var.web_ami}"
    instance_type           = "${var.web_instance_type}"
    # security_groups         = ["${var.web_sg_id}"]
    key_name                = "${var.web_key_name}"
    user_data               = "${file("${var.userdata}")}"    
}

############### AUTOSCALING GROUP ##############################################
# resource "aws_autoscaling_group" "web_asg" {
#     launch_configuration        = "${aws_launch_configuration.web_server_launch_config.id}"
#     # name                        = "web_server_asg"
#     availability_zones          = ["${var.region}a", "${var.region}b"]
#     max_size                    = "${var.autoscaling_max_size}"
#     min_size                    = "${var.autoscaling_min_size}"
#     health_check_grace_period   = "${var.autoscaling_health_check_gc}"
#     health_check_type           = "${var.autoscaling_health_check_type}"
#     desired_capacity            = "${var.autoscaling_desired_size}"
#     target_group_arns           = ["${aws_alb_target_group.web_alb_tg.arn}"]
# }

# ############################## ASG POLICY ###############################

# resource "aws_autoscaling_policy" "web_server_scale_up_policy" {
#   name                      = "scale up policy"
#   autoscaling_group_name    = "${aws_autoscaling_group.web_asg.name}"
#   policy_type               = "SimpleScaling"
#   scaling_adjustment        = "1"
#   adjustment_type           = "ChangeInCapacity"
# }

# resource "aws_autoscaling_policy" "web_server_scale_down_policy" {
#   name                      = "scale down policy"
#   autoscaling_group_name    = "${aws_autoscaling_group.web_asg.name}"
#   policy_type               = "SimpleScaling"
#   scaling_adjustment        = "-1"
#   adjustment_type           = "ChangeInCapacity"
# }