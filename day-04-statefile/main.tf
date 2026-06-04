resource "aws_instance" "ec2" {
  ami           = "ami-00e801948462f718a" # Example Amazon Linux 2023 AMI (ap-south-1)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.name.id

  tags = {
    Name = "terraform"
  }
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "name" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.0.0/26"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "name2" {
  vpc_id     = aws_vpc.name.id
  cidr_block = "10.0.0.64/26"

  tags = {
    Name = "public-subnet-2"
  }
}
