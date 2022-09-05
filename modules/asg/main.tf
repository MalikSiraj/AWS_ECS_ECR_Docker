data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

data "aws_key_pair" "MyEC2Key" {
  key_name = "AlwaysEC2"
}

resource "aws_launch_configuration" "lc" {
  name          = "test_ecs"
  image_id      = data.aws_ami.amazon_linux.id
  key_name = data.aws_key_pair.MyEC2Key.key_name
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = var.ecs_service_role_name
  security_groups             = [var.security_group_ec2_id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "asg" {
  name                      = "test-asg"
  launch_configuration      = aws_launch_configuration.lc.name
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = var.public_subnets

  target_group_arns     = [var.lb_target_group_arn]
  protect_from_scale_in = true
  lifecycle {
    create_before_destroy = true
  }
}