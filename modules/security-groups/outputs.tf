output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_sg.id
}
output "internal_alb_sg" {
  value = aws_security_group.internal_alb_sg.id
}

