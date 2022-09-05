module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  #version        = "2.38.0"
  name           = "Nginx-VPC-Assignment5"
  cidr           = "10.13.0.0/16"
  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets = ["10.13.1.0/24", "10.13.2.0/24", "10.13.3.0/24"]
  private_subnets = ["10.13.4.0/24", "10.13.5.0/24", "10.13.6.0/24"]
  enable_nat_gateway = true
  tags = {
    "env"       = "dev"
    "createdBy" = "Siraj"
  }
}

module "alb" {
  source = "./modules/alb"
  alb_public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
  security_group_lb = module.security_group.security_group_lb
}
module "security_group" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  
}

module "asg" {
  source = "./modules/asg"
  vpc_id = module.vpc.vpc_id
  ecs_service_role_name = module.iam.ecs_service_role_name
  public_subnets = module.vpc.private_subnets
  lb_target_group_arn = module.alb.lb_target_group_arn
  security_group_ec2_id = module.security_group.security_group_ec2_id
}
module "ecs" {
  source = "./modules/ecs"
  autoscaling_group_arn = module.asg.autoscaling_group_arn
  lb_target_group_arn = module.alb.lb_target_group_arn
  lb_listener = module.alb.lb_listener
 
}
module "iam" {
  source = "./modules/iam"
  
}