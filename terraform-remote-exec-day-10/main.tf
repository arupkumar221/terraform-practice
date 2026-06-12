resource "aws_instance" "web" {
  ami           = "ami-0152204c1a187337c"
  instance_type = "t2.micro"
  key_name      = "arup-key"

  tags = {
    Name = "apache-server-arup"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("arup-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
  inline = [
    "sudo yum install httpd -y",
    "sudo systemctl start httpd",
    "sudo bash -c 'cat > /var/www/html/index.html <<EOF\n<html>\n<head>\n<style>\nbody { text-align:center; font-family:Arial; }\nh1 { color:blue; }\n</style>\n</head>\n<body>\n<h1>Arup Terraform Demo</h1>\n<p>Provisioned by Terraform</p>\n</body>\n</html>\nEOF'"
  ]
} 
  }
