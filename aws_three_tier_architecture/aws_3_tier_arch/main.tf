provider "aws" {
    region  = "${var.region}"
    profile = "${var.profile}"
}

module "vpc" {
  source = "./modules/vpc"
  
}

module "servers" {
  source                = "./modules/servers"
  vpc_id                = "${module.vpc.vpc_id}"
  web_subnet_1_id       = "${module.vpc.web_subnet_1_id}"
  web_subnet_2_id       = "${module.vpc.web_subnet_2_id}"
  web_sg_id             = "${module.vpc.web_sg_id}"
  app_subnet_1_id       = "${module.vpc.app_subnet_1_id}"
  app_subnet_2_id       = "${module.vpc.app_subnet_2_id}"
  app_sg_id             = "${module.vpc.app_sg_id}"
  rds_subnet_group_name = "${module.vpc.rds_subnet_group_name}"
  lb_sg_id              = "${module.vpc.lb_sg_id}"
  userdata              = "userdata.sh"
}
