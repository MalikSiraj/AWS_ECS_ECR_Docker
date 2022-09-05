variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
  default = "ECS-cluster"
}
variable "autoscaling_group_arn" {
  description = "Autoscaling group arn"
}
variable "lb_target_group_arn" {
  description = "Load valancer target group"
  
}
variable "lb_listener" {
  description = "load balancer listerner"
}