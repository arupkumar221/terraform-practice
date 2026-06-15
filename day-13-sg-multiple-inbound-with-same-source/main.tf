# get default VPC

data "aws_vpc" "default" {

  default = true

}



resource "aws_security_group" "web_sg" {


  name = "terraform-web-sg"


  vpc_id = data.aws_vpc.default.id



  dynamic "ingress" {

    for_each = [22,80,443]


    content {

      description = "Allow ${ingress.value}"

      from_port = ingress.value

      to_port = ingress.value

      protocol = "tcp"

      cidr_blocks = [
        "0.0.0.0/0"
      ]

    }

  }



  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

}



resource "aws_instance" "web" {


  ami = "ami-0521cb2d60cfbb1a6"


  instance_type = "t3.micro"



  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]



  tags ={

    Name = "terraform-ec2"

  }

}