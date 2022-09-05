output "autoscaling_group_arn" {
    description = "Autoscaling group"
    value = aws_autoscaling_group.asg.arn
}

output "launch_configuration" {
    value = aws_launch_configuration.lc
  
}