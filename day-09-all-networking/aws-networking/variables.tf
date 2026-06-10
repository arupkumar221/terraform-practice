variable "vpc_cidr" {

}

variable "subnet_cidr" {
    type = string
    default = ""
}

variable "ami_id" {
    type = string
    default = ""

}

variable "instance_type" {
    type = string
    default = "value"
}

variable "bucket_name" {
    type = string
    default = "value"
}