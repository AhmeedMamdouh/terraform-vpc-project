output "instance_ids" {
  value = aws_instance.backend[*].id
}

