module "networking" {
  source = "./aws-networking"

  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  ami_id        = var.ami_id
  instance_type = var.instance_type
  bucket_name   = var.bucket_name
}