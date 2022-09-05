output "security_group_lb" {
    value = aws_security_group.lb
}
output "security_group_ec2_id" {
    value = aws_security_group.ec2-public-sg.id
}