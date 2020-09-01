output "vpc_id" {
  value = "${aws_vpc.sample_vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.sample_vpc.cidr_block}"
}

output "web_subnet_1_id" {
  value = "${aws_subnet.web_subnet_1.id}"
}

output "web_subnet_2_id" {
  value = "${aws_subnet.web_subnet_2.id}"
}

output "app_subnet_1_id" {
  value = "${aws_subnet.app_subnet_1.id}"
}

output "app_subnet_2_id" {
  value = "${aws_subnet.app_subnet_2.id}"
}

output "db_subnet_1_id" {
  value = "${aws_subnet.db_subnet_1.id}"
}

output "db_subnet_2_id" {
  value = "${aws_subnet.db_subnet_2.id}"
}

output "rds_subnet_group_name" {
  value = "${aws_db_subnet_group.rds_subnet.name}"
}

output "web_route_table_id" {
  value = "${aws_route_table.web_route_table.id}"
}

output "app_route_table_id" {
  value = "${aws_route_table.app_route_table.id}"
}

output "web_sg_id" {
  value = "${aws_security_group.web_security_group.id}"
}

output "app_sg_id" {
  value = "${aws_security_group.app_security_group.id}"
}

output "db_sg_id" {
  value = "${aws_security_group.db_security_group.id}"
}

output "lb_sg_id" {
  value = "${aws_security_group.lb_security_group.id}"
}
