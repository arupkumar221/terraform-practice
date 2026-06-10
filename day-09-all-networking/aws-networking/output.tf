output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "subnet_id" {
  value = aws_subnet.mysubnet.id
}

output "instance_id" {
  value = aws_instance.server.id
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}