resource "aws_instance" "backend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.backend_sg_id]

  tags = {
    Name = "backend-instance"
  }
}

