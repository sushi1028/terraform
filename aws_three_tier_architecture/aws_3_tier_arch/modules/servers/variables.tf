
variable "region" {
    default = "us-east-2"
}
variable "web_ami" {
    default = "ami-0fc20dd1da406780b"
}

variable "vpc_id" {}
variable "web_subnet_1_id" {}
variable "web_sg_id" { }
variable "web_subnet_2_id" { }
variable "app_subnet_1_id" { }
variable "app_sg_id" { }
variable "app_subnet_2_id" {}
variable "rds_subnet_group_name" {}
variable "lb_sg_id" {}

variable "userdata" { }

variable "web_instance_type" {
    default = "t2.micro"
}

variable "app_ami" {
    default = "ami-0fc20dd1da406780b"
}

variable "app_instance_type" {
    default = "t2.micro"
}

variable "web_key_name" {
    default = "pub"
}

variable "rds_storage" {
  default     = "10"
}

variable "rds_engine" {
  default     = "mysql"
}

variable "rds_instance_class" {
  default     = "db.t2.micro"
}

variable "rds_name" {
  default     = "mysql_rds"
}

variable "rds_username" {
  default     = "coditas"
}

variable "rds_password" {
  default     = "coditas1234"
}

variable "autoscaling_max_size" {
  default = 5
}

variable "autoscaling_min_size" {
  default = 1
}

variable "autoscaling_health_check_gc" {
  default = "300"
}

variable "autoscaling_health_check_type" {
  default = "ELB"
}

variable "autoscaling_desired_size" {
  default = 1
}
