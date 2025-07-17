variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet where NAT will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to associate with NAT route table"
  type        = list(string)
}

