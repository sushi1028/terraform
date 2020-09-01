variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "web_1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "web_2_cidr_block" {
  default = "10.0.2.0/24"
}

variable "app_1_cidr_block" {
  default = "10.0.3.0/24"
}

variable "app_2_cidr_block" {
  default = "10.0.4.0/24"
}

variable "db_1_cidr_block" {
  default = "10.0.5.0/24"
}

variable "db_2_cidr_block" {
  default = "10.0.6.0/24"
}