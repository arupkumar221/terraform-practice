resource "aws_instance" "server" {
  ami           = "ami-0152204c1a187337c"
  instance_type = "t3.micro"

  tags = {
    Name = "MyServer-arup"
  }
}