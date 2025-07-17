output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "subnet_cidrs" {
  value = aws_subnet.public_subnets[*].cidr_block
}

