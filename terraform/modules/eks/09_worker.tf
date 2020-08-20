# eks worker
resource "aws_launch_configuration" "worker" {
  name                 = "${local.lower_name}-launch-configuration"
  image_id             = var.worker_instance_ami
  instance_type        = var.worker_instance_type
  iam_instance_profile = aws_iam_instance_profile.worker.name
  user_data_base64     = base64encode(data.template_file.userdata.rendered)

  key_name        = var.worker_key_pair_name
  security_groups = [aws_security_group.workers.id]

  root_block_device {
    volume_type           = var.worker_ebs_volume_type
    volume_size           = var.worker_ebs_volume_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "worker" {
  name = "wap_lab_asg_${local.lower_name}"

  min_size         = var.worker_autoscale_min
  max_size         = var.worker_autoscale_max
  desired_capacity = var.worker_autoscale_desired

  vpc_zone_identifier = var.subnet_ids

  launch_configuration = aws_launch_configuration.worker.id

  tags = concat(
    [
      {
        key                 = "asg:lifecycle"
        value               = "normal"
        propagate_at_launch = true
      },
    ],
    local.worker_tags
  )
}

