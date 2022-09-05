variable "alb_public_subnets" {
    description = "Public subnets"
}
variable "vpc_id" {
    description = "VPC ID to deploy ALB"
}
variable "security_group_lb" {
    description = "Applicaiton load balancer security group"
}