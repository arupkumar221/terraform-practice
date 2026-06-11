resource "aws_db_instance" "db" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"

  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  skip_final_snapshot = true
}