terraform {
  backend "s3" {
    bucket = "statefilehuhuxhub"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}