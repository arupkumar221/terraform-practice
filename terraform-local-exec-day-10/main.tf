resource "aws_instance" "demo" {
  ami           = "ami-0152204c1a187337c"
  instance_type = "t2.micro"
  tags = {
    Name = "arup-ec2"
  }

  provisioner "local-exec" {
    command = "echo EC2 Created Successfully > output.txt"
  }
}