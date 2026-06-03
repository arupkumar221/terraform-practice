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