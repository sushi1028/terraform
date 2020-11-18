variable "region" {
    description = "AWS Region"
    default = "us-east-1"
}

variable "profile" {
    description = "AWS Profile"
    default = "default"
}

variable "env" {
    description = "Infrastructure env (e.g. developemt, production, staging)"
    default = "development"
}

variable "alb_name" {
    description = "Name of the alb"
    default = "MyALB"
}

variable "lb_type" {
    description = "Type of load-balancer"
    default = "application"
}

variable "is_internal" {
    description = "Is it a internal load balancer. Enter True or false"
    default = false
}

variable "alb_subnet_ids" {
    description = "Enter the list of subnet ids"
    type = list
    default = ["subnet-3c3bae32","subnet-56ad7477","subnet-a83755e5","subnet-ac66baf3","subnet-d0fe18e1","subnet-f715c691"]
}

variable "vpc_id" {
    description = "Enter the vpc id"
    default = "vpc-0725ca7a"
}

variable "alb_logging_bucket" {
    description = "Bucket to store s3 logs"
    default = "userzero-alb-logging"
}

variable "alb_enable_deletion_protection" {
    description = "if enable deletion protection true/false"
    default = false
}
variable "app_name_1" {
    description = "Name of application 1"
    default = "app1"
}

variable "app_name_2" {
    description = "Name of application 2"
    default = "app2"
}

variable "app_name_3" {
    description = "Name of application 3"
    default = "app3"
}

## Target Group Variables
variable "tg_port" {
    description = "Port of Target Groups"
    default = 80
}

variable "tg_protocol" {
    description = "Target group protocol"
    default = "HTTP"
}

variable "health_check_path" {
    description = "Path for target group health check"
    default = "/"
}

variable "health_check_port" {
    description = "Port for health check"
    default = 80
}

variable "healthy_threshold" {
    description = "The number of consecutive health checks successes required"
    default = 5
}

variable "unhealthy_threshold" {
    description = "The number of consecutive health check failures required before considering the target unhealthy"
    default = 2
}

variable "health_check_protocol" {
    description = "Protocol for Health check"
    default = "HTTP"
}

variable "health_check_timeout" {
    description = "The amount of time, in seconds, during which no response means a failed health check."
    default = 5
}

variable "health_check_interval" {
    description = "The approximate amount of time, in seconds, between health checks of an individual target."
    default = 10
}

variable "health_check_matcher" {
    description = "The HTTP codes to use when checking for a successful response from a target"
    default = "200,202"
}

## Autoscaling Variables ##
variable "image_id" {
    description = "Image ID for EC2"
    default = "ami-0947d2ba12ee1ff75"
}

variable "instance_key" {
    description = "ASG instance key for login"
    default = "userzero"
}

variable "instance_type" {
    description = "ASG instance type"
    default = "t2.micro"
}

variable "autoscaling_subnets" {
    description = "Subnets for autoscaling group"
    type = list 
    default = ["subnet-3c3bae32","subnet-56ad7477","subnet-a83755e5"]
}

variable "max_size" {
    description = "ASG max capacity"
    default = 5
}

variable "min_size" {
    description = "ASG min size"
    default = 1
}

variable "health_check_grace_period" {
    description = "Health check grace period"
    default = 30
}

variable "health_check_type" {
    description = "Type of health check. EC2/ALB"
    default = "EC2"
}

variable "desired_capacity" {
    description = "Number of desired capacity"
    default = 2
}

variable "force_delete" {
    description = "Should be ASG force delete enabled ? True/False"
    default = true
}

##