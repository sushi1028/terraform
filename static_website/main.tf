provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

module "s3" {
    source = "./modules/s3"
}

module "cloudfront" {
    source = "./modules/cloudfront"
}
