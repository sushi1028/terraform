resource "aws_vpc" "sample_vpc" {
    cidr_block          = "${var.vpc_cidr_block}"

    tags = {
        Name = "sample-vpc"
    }
}

####################### WEB SUBNET (PUBLIC) ##########################
resource "aws_subnet" "web_subnet_1" {
    vpc_id              = "${aws_vpc.sample_vpc.id}"
    cidr_block          = "${var.web_1_cidr_block}"
    availability_zone   = "${var.region}a"

    tags = {
        Name = "web-subnet-1"
    }

}

resource "aws_subnet" "web_subnet_2" {
    vpc_id              = "${aws_vpc.sample_vpc.id}"
    cidr_block          = "${var.web_2_cidr_block}"
    availability_zone   = "${var.region}b"

    tags = {
        Name = "web-subnet-2"
    }
}

################## APP SUBNET ######################################

resource "aws_subnet" "app_subnet_1" {
    vpc_id              = "${aws_vpc.sample_vpc.id}"
    cidr_block          = "${var.app_1_cidr_block}"
    availability_zone   = "${var.region}a"

    tags = {
        Name = "app_subnet_1"
    }
}

resource "aws_subnet" "app_subnet_2" {
    vpc_id              = "${aws_vpc.sample_vpc.id}"
    cidr_block          = "${var.app_2_cidr_block}"
    availability_zone   = "${var.region}b"

    tags = {
        Name = "app_subnet_2"
    }
}

################### DB SUBNET ###############################################
resource "aws_subnet" "db_subnet_1" {
    vpc_id              = "${aws_vpc.sample_vpc.id}"
    cidr_block          = "${var.db_1_cidr_block}"
    availability_zone   = "${var.region}a"

    tags = {
        Name = "db_subnet_1"
    }
}

resource "aws_subnet" "db_subnet_2" {
    vpc_id              = "${aws_vpc.sample_vpc.id}"
    cidr_block          = "${var.db_2_cidr_block}"
    availability_zone   = "${var.region}b"

    tags = {
        Name = "db_subnet_2"
    }
}

################## RDS SUBNET GROUP ################################

resource "aws_db_subnet_group" "rds_subnet" {
    name        = "rds_subnet_group"
    subnet_ids  = ["${aws_subnet.db_subnet_1.id}","${aws_subnet.db_subnet_2.id}"]

    tags = {
        Name = "rds_subnet_group"
    }
}

################## INTERNET GATEWAY ################################

resource "aws_internet_gateway" "igw" {
    vpc_id  = "${aws_vpc.sample_vpc.id}"

    tags = {
        Name = "sample-igw"
    }
}

################ WEB ROUTE TABLE ##################################

resource "aws_route_table" "web_route_table" {
    vpc_id = "${aws_vpc.sample_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = {
        Name = "pub_route_table"
    }
}

######################## NAT GATEWAY ################################
resource "aws_eip" "nat_ip" {
  vpc   = true

  tags = {
    Name = "nat_eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id   = "${aws_eip.nat_ip.id}"
    subnet_id       = "${aws_subnet.web_subnet_1.id}"

    tags = {
        Name = "nat_gateway"
    }
}


#################### APP ROUTE TABLE #################################

# need elastic ip for nat gateway
resource "aws_route_table" "app_route_table" {
    vpc_id = "${aws_vpc.sample_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_gw.id}"
    }

    tags = {
        Name = "app_route_table"
    }
}

################ WEB ROUTE TABLE ASSOCIATION ########################

resource "aws_route_table_association" "web_route_table_assoc_1" {  
    subnet_id       = "${aws_subnet.web_subnet_1.id}"
    route_table_id  = "${aws_route_table.web_route_table.id}"
}

resource "aws_route_table_association" "web_route_table_assoc_2" {
    subnet_id       = "${aws_subnet.web_subnet_2.id}"
    route_table_id  = "${aws_route_table.web_route_table.id}"  
}

################ APP ROUTE TABLE ASSOCIATION ###########################

resource "aws_route_table_association" "app_rote_table_assoc_1" {
    subnet_id       = "${aws_subnet.app_subnet_1.id}"
    route_table_id  = "${aws_route_table.app_route_table.id}"
}

resource "aws_route_table_association" "app_rote_table_assoc_2" {
    subnet_id       = "${aws_subnet.app_subnet_2.id}"
    route_table_id  = "${aws_route_table.app_route_table.id}"
}

######################### WEB SECURITY GROUP ################################

resource "aws_security_group" "web_security_group" {
    vpc_id      = "${aws_vpc.sample_vpc.id}"
    name        =  "web_security_group"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        # source_security_group_id = "${aws_security_group.lb_security_group.id}"
        cidr_blocks     = ["${var.vpc_cidr_block}"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
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

    Name = "web_security_group"
  
  }
}

#################### APP SECURITY GROUP ####################################

resource "aws_security_group" "app_security_group" {
    vpc_id  = "${aws_vpc.sample_vpc.id}"
    name    = "app security group"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        # source_security_group_id  = ["${aws_security_group.web_security_group.id}"]
        cidr_blocks     = ["${var.vpc_cidr_block}"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
         Name = "app_security_group"
    }
}

################# DB SECURITY GROUP ########################################

resource "aws_security_group" "db_security_group" {
    vpc_id  = "${aws_vpc.sample_vpc.id}"
    name    = "db security group"

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        # source_security_group_id  = ["${aws_security_group.app_security_group.id}"]
        cidr_blocks     = ["${var.vpc_cidr_block}"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "db_security_group"
  }

}

#################### LB SECURITY GROUPS ###################################

resource "aws_security_group" "lb_security_group" {
    vpc_id  = "${aws_vpc.sample_vpc.id}"
    name    = "lb security group"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags =  {
        Name = "lb_sg"
    }  
}
