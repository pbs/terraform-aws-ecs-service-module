resource "aws_appautoscaling_target" "autoscaling_target" {
  resource_id        = "service/${local.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

resource "aws_appautoscaling_policy" "cpu_autoscaling_policy" {
  count              = var.scaling_approach == "target_tracking_scaling" ? 1 : 0
  name               = "${local.name}-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.target_cpu_utilization
  }
}

resource "aws_appautoscaling_policy" "memory_autoscaling_policy" {
  count              = var.scaling_approach == "target_tracking_scaling" ? 1 : 0
  name               = "${local.name}-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.autoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = var.target_memory_utilization
  }
}

resource "aws_appautoscaling_policy" "scale_up_policy" {
  count              = var.scaling_approach == "step_scaling" ? 1 : 0
  name               = "${local.name}-scale-up-policy"
  resource_id        = "service/${local.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  service_namespace = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_up_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_up_adjustment
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down_policy" {
  count              = var.scaling_approach == "step_scaling" ? 1 : 0
  name               = "${local.name}-scale-down-policy"
  resource_id        = "service/${local.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  service_namespace = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_down_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_down_adjustment
    }
  }
}

# these two alarms are essentially an OR for scaling up - either will trigger scaling
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count               = var.scaling_approach == "step_scaling" ? 1 : 0
  alarm_name          = "${local.name}-cpu-high"
  alarm_description   = "This alarm monitors ${local.name} CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_up_cpu_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_up_policy[0].arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm CPU High" },
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  count               = var.scaling_approach == "step_scaling" ? 1 : 0
  alarm_name          = "${local.name}-memory-high"
  alarm_description   = "This alarm monitors ${local.name} web memory utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_up_memory_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_up_policy[0].arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm Memory High" },
  )
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count               = var.scaling_approach == "step_scaling" ? 1 : 0
  alarm_name          = "${local.name}-cpu-low"
  alarm_description   = "This alarm monitors ${local.name} web CPU utilization for scaling down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_down_cpu_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_down_policy[0].arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm CPU Low" },
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  count               = var.scaling_approach == "step_scaling" ? 1 : 0
  alarm_name          = "${local.name}-memory-low"
  alarm_description   = "This alarm monitors ${local.name} web memory utilization for scaling down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scaling_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.scaling_evaluation_period
  statistic           = "Average"
  threshold           = var.scale_down_memory_threshold
  alarm_actions       = [aws_appautoscaling_policy.scale_down_policy[0].arn]

  dimensions = {
    ClusterName = local.cluster
    ServiceName = aws_ecs_service.service.name
  }

  tags = merge(
    local.tags,
    { Name = "${local.name} CW Metric Alarm Memory Low" },
  )
}
