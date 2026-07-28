resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "evoting-vpc"
  }
}
resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public1.id
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}
resource "aws_security_group" "bastion_sg" {
  name   = "bastion-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "frontend_sg" {
  name = "frontend-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [
      aws_security_group.bastion_sg.id
    ]
  }
}
resource "aws_security_group" "backend_sg" {
  name = "backend-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    security_groups = [
      aws_security_group.frontend_sg.id
    ]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [
      aws_security_group.bastion_sg.id
    ]
  }
}
resource "aws_instance" "bastion" {
  ami = var.ami_id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public1.id
  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]
}
resource "aws_instance" "frontend" {
  ami = var.ami_id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private1.id
  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]
}
resource "aws_instance" "backend" {
  ami = var.ami_id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private2.id
  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.backend_sg.id
  ]
}
resource "aws_lb" "evoting_alb" {
  name = "evoting-alb"
  internal = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}
resource "aws_lb_target_group" "frontend_tg" {
  name = "frontend-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}
resource "aws_lb_target_group_attachment" "frontend" {
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id = aws_instance.frontend.id
  port = 80
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.evoting_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}
