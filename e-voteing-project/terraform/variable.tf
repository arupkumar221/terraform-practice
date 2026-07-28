variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "evoting"
}

variable "ami_id" {}

variable "key_name" {
  default = "evoting-key"
}
variable "my_ip" {
  description = "Your public IP address"
  type        = string
}