
resource "aws_instance" "web" {

  ami           = "ami-0152204c1a187337c"
  instance_type = "t2.micro"
  key_name      = "arup-key"

  tags = {
    Name = "arup-file-provisioner"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("arup-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]
  }
}