resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "Terraform-1100AM"
    }
  
}
resource "aws_instance" "ec2" {
  ami           = "ami-00e801948462f718a" 
  instance_type = "t3.micro"


  tags = {
    Name = "terraform2"
  }
}
