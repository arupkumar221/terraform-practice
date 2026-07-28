output "vpc_id" {

  value = aws_vpc.main.id

}

output "public_subnet_id" {

  value = aws_subnet.public.id

}

output "private_subnet1_id" {

  value = aws_subnet.private1.id

}

output "private_subnet2_id" {

  value = aws_subnet.private2.id

}

output "security_group_id" {

  value = aws_security_group.aurora_sg.id

}

output "cluster_endpoint" {

  value = aws_rds_cluster.aurora.endpoint

}

output "reader_endpoint" {

  value = aws_rds_cluster.aurora.reader_endpoint

}

output "writer_instance" {

  value = aws_rds_cluster_instance.writer.id

}

output "reader_instance" {

  value = aws_rds_cluster_instance.reader.id

}