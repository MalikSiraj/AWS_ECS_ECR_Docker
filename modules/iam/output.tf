output "ecs_service_role_name" {
    value = aws_iam_instance_profile.ecs_service_role.name
}