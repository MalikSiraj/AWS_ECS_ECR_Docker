output "lb_listener" {
    value = aws_lb_listener.web-listener
}
output "lb_target_group_arn" {
    value = aws_lb_target_group.lb_target_group.arn
}
output "lb" {
    value = aws_lb.test-lb
}