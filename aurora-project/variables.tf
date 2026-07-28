variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet1_cidr" {
  description = "Private Subnet 1 CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet2_cidr" {
  description = "Private Subnet 2 CIDR"
  type        = string
  default     = "10.0.3.0/24"
}

variable "db_username" {
  description = "Aurora Master Username"
  type        = string
}

variable "db_password" {
  description = "Aurora Master Password"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Aurora Instance Type"
  type        = string
  default     = "db.t3.medium"
}