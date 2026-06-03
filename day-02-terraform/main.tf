resource "aws_instance" "my_instance" {
  ami          = var.ami-id
  instance_type = var.instance_type

  tags = {
    Name = "terraform-server"
  }
}