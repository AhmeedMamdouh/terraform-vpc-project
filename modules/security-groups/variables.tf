variable "vpc_id" {
  description = "VPC ID to associate with the security groups"
  type        = string
}
variable "proxy_cidrs" {
  type = list(string)
}

