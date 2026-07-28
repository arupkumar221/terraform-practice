########################################
# VPC
########################################

resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aurora-vpc"
  }
}

########################################
# Internet Gateway
########################################

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "aurora-igw"
  }
}

########################################
# Public Subnet
########################################

resource "aws_subnet" "public" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

########################################
# Private Subnet 1
########################################

resource "aws_subnet" "private1" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-1"
  }
}

########################################
# Private Subnet 2
########################################

resource "aws_subnet" "private2" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2"
  }
}

########################################
# Public Route Table
########################################

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }

  tags = {
    Name = "public-route-table"
  }

}

########################################
# Route Table Association
########################################

resource "aws_route_table_association" "public_association" {

  subnet_id      = aws_subnet.public.id

  route_table_id = aws_route_table.public_rt.id

}

########################################
# Security Group
########################################

resource "aws_security_group" "aurora_sg" {

  name        = "aurora-security-group"

  description = "Aurora MySQL Security Group"

  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 3306

    to_port = 3306

    protocol = "tcp"

    cidr_blocks = ["10.0.0.0/16"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "aurora-sg"
  }

}

########################################
# DB Subnet Group
########################################

resource "aws_db_subnet_group" "aurora" {

  name = "aurora-db-subnet-group"

  subnet_ids = [

    aws_subnet.private1.id,

    aws_subnet.private2.id

  ]

  tags = {

    Name = "aurora-db-subnet-group"

  }

}

########################################
# Aurora Cluster
########################################

resource "aws_rds_cluster" "aurora" {

  cluster_identifier = "aurora-mysql-cluster"

  engine = "aurora-mysql"

  engine_version = "8.0.mysql_aurora.3.04.0"

  master_username = var.db_username

  master_password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.aurora.name

  vpc_security_group_ids = [

    aws_security_group.aurora_sg.id

  ]

  backup_retention_period = 7

  preferred_backup_window = "07:00-09:00"

  storage_encrypted = true

  skip_final_snapshot = true

  tags = {

    Name = "Aurora-Cluster"

  }

}

########################################
# Writer Instance
########################################

resource "aws_rds_cluster_instance" "writer" {

  identifier = "aurora-writer"

  cluster_identifier = aws_rds_cluster.aurora.id

  instance_class = var.instance_class

  engine = aws_rds_cluster.aurora.engine

  engine_version = aws_rds_cluster.aurora.engine_version

  publicly_accessible = false

  db_subnet_group_name = aws_db_subnet_group.aurora.name

  tags = {

    Name = "Aurora-Writer"

  }

}

########################################
# Reader Instance
########################################

resource "aws_rds_cluster_instance" "reader" {

  identifier = "aurora-reader"

  cluster_identifier = aws_rds_cluster.aurora.id

  instance_class = var.instance_class

  engine = aws_rds_cluster.aurora.engine

  engine_version = aws_rds_cluster.aurora.engine_version

  publicly_accessible = false

  db_subnet_group_name = aws_db_subnet_group.aurora.name

  tags = {

    Name = "Aurora-Reader"

  }

}