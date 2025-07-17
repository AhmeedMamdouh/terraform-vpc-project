output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}
output "subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

