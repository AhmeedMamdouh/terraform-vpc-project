module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "dev-vpc"
}
module "public_subnets" {
  source              = "./modules/public-subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                 = ["us-east-1a", "us-east-1b"]
}
module "private_subnets" {
  source               = "./modules/private-subnets"
  vpc_id               = module.vpc.vpc_id
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}
module "nat_gateway" {
  source             = "./modules/nat-gateway"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.public_subnets.public_subnet_ids[0]
  private_subnet_ids = module.private_subnets.private_subnet_ids
}
module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
  proxy_cidrs = module.public_subnets.subnet_cidrs
}
module "ec2_backend" {
  source        = "./modules/ec2-backend"
  ami_id        = "ami-0c02fb55956c7d316" # مثال
  instance_type = "t2.micro"
  subnet_id     = module.private_subnets.private_subnet_ids[0]
  backend_sg_id = module.security_groups.backend_sg_id
}
module "alb_public" {
  source              = "./modules/alb-public"
  subnet_ids          = module.public_subnets.public_subnet_ids
  alb_sg_id           = module.security_groups.alb_sg_id
  vpc_id              = module.vpc.vpc_id
  backend_instance_ids = module.ec2_backend.instance_ids
}
module "alb_internal" {
  source               = "./modules/alb-internal"
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.private_subnets.subnet_ids
  backend_instance_ids = module.ec2_backend.instance_ids
  alb_sg_id            = module.security_groups.internal_alb_sg
}

