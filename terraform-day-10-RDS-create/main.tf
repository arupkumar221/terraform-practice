module "database" {
  source = "./modules/rds"

  db_name        = "mydatabase"
  db_username    = "admin"
  db_password    = "Password123!"
  instance_class = "db.t3.micro"
}