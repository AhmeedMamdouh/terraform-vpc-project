variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}
variable "backend_instance_ids" {
  description = "IDs of the backend EC2 instances"
  type        = list(string)
}

