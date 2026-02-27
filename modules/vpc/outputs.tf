output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public.id, aws_subnet.public_secondary.id]
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet_ids" {
  value = [aws_subnet.private.id, aws_subnet.private_secondary.id]
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
