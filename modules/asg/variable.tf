variable "vpc_id" {
    description = "VPC ID to deploy ALB"
}
variable "ecs_service_role_name" {
    description = "Name of Service role for ECS"
}
variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration"
  default = "AlwaysEC2"
}

variable "public_subnets" {
    description = "Public subnets"
}
variable "lb_target_group_arn" {
    description = "Target group arn"
}
variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
  default = "ECS-cluster"
}
variable "security_group_ec2_id" {
  description = "EC2 Security group" 
}